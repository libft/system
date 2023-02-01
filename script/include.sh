#!/bin/sh

set -e

rm -rf ".ft/.cache/include"
trap 'rm -rf -- ".ft/.cache/include"' EXIT
mkdir -p ".ft/.cache/include"

sh script/find_modules.sh | grep /h. | sort | while IFS= read -r line
do
  FT_LOAD_NAME_AND_EDITION="${line##*/h.}"
  FT_LOAD_NAME="${FT_LOAD_NAME_AND_EDITION%%.*}"
  cp "$line/$FT_LOAD_NAME.h" ".ft/.cache/include"
done

rm -rf .ft/include
mv ".ft/.cache/include" .ft
