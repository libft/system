#!/bin/sh

set -e

FT_LOAD_MODULE_DEPTH="${FT_LOAD_MODULE_DEPTH-} "
export FT_LOAD_MODULE_DEPTH
printf "%sLoading module %s\n" "$FT_LOAD_MODULE_DEPTH" "$1"

. "$(dirname "$0")/common.sh"

if [ -d ".ft/module/$1" ]; then
  exit
fi

FT_LOAD_PATH="$(grep "$1=" < "$FT_BASE_PATH/.ft/.cache/module_list.properties")"
if [ -z "$FT_LOAD_PATH" ]; then
  echo "Error: failed to find module \"$1\""
  exit 1
fi
FT_LOAD_PATH=${FT_LOAD_PATH#*=}

cat "$FT_BASE_PATH/$FT_LOAD_PATH/ft_dependencies.ft" | while IFS= read -r line
do
  if [ ! -d ".ft/module/$line" ]; then
    sh "$FT_BASE_PATH/script/load_module_recursive.sh" "$line"
  fi
done

if [ ! -d ".ft/module/$1" ]; then
  sh "$FT_BASE_PATH/script/load_module_shallow.sh" "$1"
fi
