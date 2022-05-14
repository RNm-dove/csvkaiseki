#!/bin/bash
if [ -z "$1" ]; then
    echo "ファイル名をいれてください。"
fi


DIRNAME=$1

echo $DIRNAME

mkdir -p answer

# .csvも表示
shopt -s dotglob
files="$DIRNAME/*"
fileary=()
dirary=()
for filepath in $files; do
  echo $filepath
  if [ -f $filepath ] ; then
    # wcの結果を整形して保存。tmp/鹿児島県/ほげほげ市というファイル名から鹿児島県ほげほげ市を抽出して行数とともに追記。
    wc -l $filepath |  tr -s ' ' | awk -F'[/. ]' '{ print $6$7","$2}' >> ./answer/"$(basename $DIRNAME).csv"
  fi
done

