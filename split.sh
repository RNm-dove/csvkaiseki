#!/bin/bash
if [ -z "$1" ]; then
    echo "ファイル名をいれてください。"
fi

FILENAME=$1

mkdir -p splitfiles
split -l 100000 $FILENAME splitfiles/data_ 