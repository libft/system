#!/bin/sh

rm -rf ".ft/.cache/home"
trap 'rm -rf -- ".ft/.cache/home"' EXIT
mkdir -p ".ft/.cache/home/src" ".ft/.cache/home/include"

find .ft/module -depth 1 -type d | cut -c 12- | while IFS= read -r line
do
  case $line in
    h.*)
      cp ".ft/module/$line/${line#h.}.h" ".ft/.cache/home/include"
      ;;
    f.*)
      FT_BUILD_HOME_NAME_AND_EDITION="${line#f.}"
      FT_BUILD_HOME_NAME="${FT_BUILD_HOME_NAME_AND_EDITION%%.*}"
      cp ".ft/module/$line/$FT_BUILD_HOME_NAME.c" ".ft/.cache/home/src"
      ;;
  esac
done

printf "SRCS := %s\ninclude \$(FT_BASE_PATH)/script/home.mk\n" "$(cd .ft/.cache/home && find src -depth 1 | sort | xargs)" > ".ft/.cache/home/Makefile"
printf "executable.exe\nlibrary.a\n.cache\n" > ".ft/.cache/home/.gitignore"

rm -rf ".ft/home"
mv ".ft/.cache/home" ".ft"
