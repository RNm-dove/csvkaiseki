#!/bin/bash
if [ -z "$1" ]; then
    echo "ファイル名をいれてください。"
fi

FILENAME=$1

mkdir -p tmp

mkdir -p tmp/北海道
mkdir -p tmp/青森県
mkdir -p tmp/岩手県
mkdir -p tmp/宮城県
mkdir -p tmp/秋田県
mkdir -p tmp/山形県
mkdir -p tmp/福島県
mkdir -p tmp/茨城県
mkdir -p tmp/栃木県
mkdir -p tmp/群馬県
mkdir -p tmp/埼玉県
mkdir -p tmp/千葉県
mkdir -p tmp/東京都
mkdir -p tmp/神奈川県
mkdir -p tmp/新潟県
mkdir -p tmp/富山県
mkdir -p tmp/石川県
mkdir -p tmp/福井県
mkdir -p tmp/山梨県
mkdir -p tmp/長野県
mkdir -p tmp/岐阜県
mkdir -p tmp/静岡県
mkdir -p tmp/愛知県
mkdir -p tmp/三重県
mkdir -p tmp/滋賀県
mkdir -p tmp/京都府
mkdir -p tmp/大阪府
mkdir -p tmp/兵庫県
mkdir -p tmp/奈良県
mkdir -p tmp/和歌山県
mkdir -p tmp/鳥取県
mkdir -p tmp/島根県
mkdir -p tmp/岡山県
mkdir -p tmp/広島県
mkdir -p tmp/山口県
mkdir -p tmp/徳島県
mkdir -p tmp/香川県
mkdir -p tmp/愛媛県
mkdir -p tmp/高知県
mkdir -p tmp/福岡県
mkdir -p tmp/佐賀県
mkdir -p tmp/長崎県
mkdir -p tmp/熊本県
mkdir -p tmp/大分県
mkdir -p tmp/宮崎県
mkdir -p tmp/鹿児島県
mkdir -p tmp/沖縄県

exec < $FILENAME || exit 1
read header
while IFS=, read -r f1 f2 f3
do
  # 〇〇市〇〇区は〇〇市にまるめこむ。
  place=`echo $f3 | sed -r -e "s/(^.*市)(.*区)/\1/g"`
  # 都道府県ごとにフォルダを作成し、市区町村ごとにファイルを作成。
  echo "$f1, $f2, $f3" >> tmp/$f2/$place.csv
done