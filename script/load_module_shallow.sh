#!/bin/sh

set -e

. "$(dirname "$0")/common.sh"

(cd "$FT_BASE_PATH" && ${MAKE-make} -s ".ft/.cache/module_list.properties")
FT_LOAD_PATH="$(grep "$1=" < "$FT_BASE_PATH/.ft/.cache/module_list.properties")"
if [ -z "$FT_LOAD_PATH" ]; then
  echo "Error: failed to find module \"$1\""
  exit 1
fi
FT_LOAD_PATH=${FT_LOAD_PATH#*=}

case $1 in
  h.*)
    FT_LOAD_NAME="${1#h.}"
    trap 'rm -rf -- ".ft/.cache/$1"' EXIT
    mkdir -p ".ft/.cache/$1"
    cp "$FT_BASE_PATH/$FT_LOAD_PATH/$FT_LOAD_NAME.h" "$FT_BASE_PATH/$FT_LOAD_PATH/ft_dependencies.ft" ".ft/.cache/$1"
    mkdir -p ".ft/module"
    rm -rf "./ft/module/$1"
    mv ".ft/.cache/$1" ".ft/module"
    ;;
  f.*)
    FT_LOAD_NAME_AND_EDITION="${1#f.}"
    FT_LOAD_NAME="${FT_LOAD_NAME_AND_EDITION%%.*}"
    trap 'rm -rf -- ".ft/.cache/$1"' EXIT
    mkdir -p ".ft/.cache/$1"
    cp "$FT_BASE_PATH/$FT_LOAD_PATH/$FT_LOAD_NAME.c" "$FT_BASE_PATH/$FT_LOAD_PATH/ft_dependencies.ft" "$FT_BASE_PATH/$FT_LOAD_PATH/ft_peer_dependencies.ft" ".ft/.cache/$1"
    mkdir -p ".ft/module"
    rm -rf "./ft/module/$1"
    mv ".ft/.cache/$1" ".ft/module"
    ;;
  b.*)
    FT_LOAD_NAME_AND_EDITION="${1#b.}"
    FT_LOAD_NAME="${FT_LOAD_NAME_AND_EDITION%%.*}"
    trap 'rm -rf -- ".ft/.cache/$1"' EXIT
    mkdir -p ".ft/.cache/$1"
    cp "$FT_BASE_PATH/$FT_LOAD_PATH/ft_dependencies.ft" ".ft/.cache/$1"
    mkdir -p ".ft/module"
    rm -rf "./ft/module/$1"
    mv ".ft/.cache/$1" ".ft/module"
    ;;
  *)
    echo "Error: Unrecognized module type: ${1%%.*}"
    exit 1
    ;;
esac
