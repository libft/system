#!/bin/sh

set -e

. "$(dirname "$0")/common.sh"

rm -rf ".ft/.cache/include"
trap 'rm -rf -- ".ft/.cache/include"' EXIT
mkdir -p ".ft/.cache/include"

(cd "$FT_BASE_PATH" && ${MAKE-make} ".ft/.cache/module_list.properties")
< "$FT_BASE_PATH/.ft/.cache/module_list.properties" grep "^h." | sort | while IFS="=" read -r name path
do
  cp "$FT_BASE_PATH/$path/${name#h.}.h" ".ft/.cache/include"
done

rm -rf .ft/include
mv ".ft/.cache/include" .ft
