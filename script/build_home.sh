#!/bin/sh

rm -rf ".ft/home"
mkdir -p ".ft/home/src" ".ft/home/include"

find .ft/module -depth 1 -type d | cut -c 12- | while IFS= read -r line
do
  case $line in
    h.*)
      FT_LOAD_NAME_AND_EDITION=$(echo "$line" | cut -c 3-)
      FT_LOAD_NAME="${FT_LOAD_NAME_AND_EDITION%%.*}"
      cp ".ft/module/$line/$FT_LOAD_NAME.h" ".ft/home/include"
      ;;
    f.*)
      FT_LOAD_NAME_AND_EDITION=$(echo "$line" | cut -c 3-)
      FT_LOAD_NAME="${FT_LOAD_NAME_AND_EDITION%%.*}"
      cp ".ft/module/$line/$FT_LOAD_NAME.c" ".ft/home/src"
      ;;
  esac
done
