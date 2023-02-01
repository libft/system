#!/bin/sh

set -e

if [ -z "$FT_FIND_MODULES_PREFIX" ]; then
  FT_FIND_MODULES_NEXT_PREFIX=""
else
  FT_FIND_MODULES_NEXT_PREFIX="$FT_FIND_MODULES_PREFIX"
fi

find . -depth 1 -type d | cut -c 3- | grep -vE ^\\.ft\$ | sort | while IFS= read -r line
do
  if [ -f "$line/ft_dependencies.ft" ]; then
    echo "./$FT_FIND_MODULES_PREFIX$line"
  else
    case $0 in
      /*)
        (cd "$line" && FT_FIND_MODULES_PREFIX="$FT_FIND_MODULES_NEXT_PREFIX$line/" sh "$0")
        ;;
      find_modules.sh|./find_modules.sh)
        (cd "$line" && FT_FIND_MODULES_PREFIX="$FT_FIND_MODULES_NEXT_PREFIX$line/" sh "../find_modules.sh")
        ;;
      *)
        (cd "$line" && FT_FIND_MODULES_PREFIX="$FT_FIND_MODULES_NEXT_PREFIX$line/" sh "../$0")
        ;;
    esac
  fi
done
