#!/bin/sh

set -e

. "$(dirname "$0")/common.sh"

cat "${1-dependencies.txt}" | while IFS= read -r line
do
  sh "$FT_BASE_PATH/script/load_module_recursive.sh" "$line"
done
sh "$FT_BASE_PATH/script/check_duplicate_module.sh"
sh "$FT_BASE_PATH/script/check_peer_dependency.sh"
