#!/bin/bash
files="./tmp/*"
fileary=()
dirary=()
for filepath in $files; do
  if [ -f $filepath ] ; then
    fileary+=("$filepath\n")
  elif [ -d $filepath ] ; then
    dirary+=("$filepath\n")
  fi
done

echo -e  ${dirary[@]} | xargs -L1 -I{} -P4 bash -c "./countDir.sh {}"

