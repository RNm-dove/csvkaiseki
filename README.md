# 使い方
大規模のcsvをmacで解析するためのスクリプト。macようのbashコマンドを使っているので、多分ほかのOSだと動かない可能性あり。

今回の解析条件は、
「なんかのデータ、都道府県、市区町村 という順番のcsvがあり、市区町村ごとにグルーピングして各市区町村の合計行数が知りたい。」
という内容。

もしcsvの形が変わる場合は、
- separate.sh
- countDir.sh
の条件をうまく書き換えればこれらのスクリプトを流用できるはず。

bashスクリプトを実行する際は、そのスクリプトが何をしているか理解してから実行すること。悪意のあるスクリプトとかだとパスワード抜かれたりするから注意。

## 準備
まずは作業用のフォルダを適当な場所に作る。その作業フォルダにこれらのスクリプトを置く。

- split.sh
- separate.sh
- parallelSeparate.sh (separate.shに依存)
- countDir.sh
- parallelCount.sh (countDir.shに依存)
- unite.sh

つぎに解析したいcsvをおなじフォルダに置く。

つぎのファイルに実行権限を付与する。パスワードが求められたらMacのパスワードを入力。
```
sudo chmod +x separate.sh
sudo chmod +x countDir.sh
```

ここまでくれば準備完了！

ファイルの構造

作業ディレクトリ
|--split.sh
|--separate.sh
|--parallelSeparate.sh
|--countDir.sh
|--parallelCount.sh
|--split.sh
|--unite.sh
|--解析したい.csv


## 工程理解
1. 巨大なcsvをそのまま解析すると時間がかかるため並列実行したい。ファイルを分割する(split.sh)。
2. 条件に応じて各行を指定のファイルへ追記していく。これは先程分割した解析したいファイルに対して並列で実行していく(parallelSeparate)。100万行ごとに4コアcpuでだいたい30弱かかる。
3. 最後にそれぞれのファイルごとに行数をカウントして、結果をだす(parallelCount)。
4. 結果ファイルを結合する。

## パラメータ
parallel系のスクリプトはxargsコマンドの-Pオプションで並列数を指定できる。使っているCPUの(コア数-2)ぐらいの数をおすすめする。

例: 並列4
```
xargs -P4
```

## 実行コマンド
すべての工程はターミナルで作業ディレクトリまで移動して実行する想定。

### 工程1
巨大ファイル分割。

```
bash split.sh 解析したい.csv
```

splitfilesに10万行ごとに分割したファイルが生成される。

### 工程2
各行を条件に応じて特定のファイルに追記。

```
bash parallelSeparate.sh
```

splitfilesディレクトリ以下のファイルを並列で分割しtmpフォルダ以下にファイルを作成して追記していく。ここに時間かかる。

### 工程3
各ファイルの行数を計算。結果をファイルに保存。

```
bash parallelCount.sh
```

tmpディレクトリ以下のファイルを並列で行数カウントしていきます。answerフォルダに結果を保存していく。

### 工程４
結果ファイルたちを一つのcsvにまとめる。

```
bash unite.sh
```

answerファイル以下のcsvファイルを結合してOUTPUT.csvを作る。


## 作業の中間ファイルの削除
すべての作業が終われば中間データを削除。

- splitfiles
- tmp
- answer# csvkaiseki
