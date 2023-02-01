#!/bin/sh

set -e

. "$(dirname "$0")/common.sh"

if [ ! -d ".ft/module/$1" ]; then
  sh "$FT_BASE_PATH/script/load_module_shallow.sh" "$1"
fi

cat ".ft/module/$1/ft_dependencies.ft" | while IFS= read -r line
do
  if [ ! -d ".ft/module/$line" ]; then
    sh "$FT_BASE_PATH/script/load_module_recursive.sh" "$line"
  fi
done
