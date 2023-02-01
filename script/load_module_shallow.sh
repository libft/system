#!/bin/sh

set -e

. "$(dirname "$0")/common.sh"

FT_LOAD_PATH=$(cd "$FT_BASE_PATH" && sh "script/find_modules.sh" | grep -E "/$1\$" | cut -c 3-)
if [ -z "$FT_LOAD_PATH" ]; then
  echo "Error: failed to find module \"$1\""
  exit 1
fi

case $1 in
  h.*)
    FT_LOAD_NAME_AND_EDITION=$(echo "$1" | cut -c 3-)
    FT_LOAD_NAME="${FT_LOAD_NAME_AND_EDITION%%.*}"
    trap 'rm -rf -- ".ft/.cache/$1"' EXIT
    mkdir -p ".ft/.cache/$1"
    cp "$FT_BASE_PATH/$FT_LOAD_PATH/$FT_LOAD_NAME.h" "$FT_BASE_PATH/$FT_LOAD_PATH/ft_dependencies.ft" ".ft/.cache/$1"
    mkdir -p ".ft/module"
    rm -rf "./ft/module/$1"
    mv ".ft/.cache/$1" ".ft/module"
    ;;
  f.*)
    FT_LOAD_NAME_AND_EDITION=$(echo "$1" | cut -c 3-)
    FT_LOAD_NAME="${FT_LOAD_NAME_AND_EDITION%%.*}"
    trap 'rm -rf -- ".ft/.cache/$1"' EXIT
    mkdir -p ".ft/.cache/$1"
    cp "$FT_BASE_PATH/$FT_LOAD_PATH/$FT_LOAD_NAME.c" "$FT_BASE_PATH/$FT_LOAD_PATH/ft_dependencies.ft" "$FT_BASE_PATH/$FT_LOAD_PATH/ft_peer_dependencies.ft" ".ft/.cache/$1"
    mkdir -p ".ft/module"
    rm -rf "./ft/module/$1"
    mv ".ft/.cache/$1" ".ft/module"
    ;;
  b.*)
    FT_LOAD_NAME_AND_EDITION=$(echo "$1" | cut -c 3-)
    FT_LOAD_NAME="${FT_LOAD_NAME_AND_EDITION%%.*}"
    trap 'rm -rf -- ".ft/.cache/$1"' EXIT
    mkdir -p ".ft/.cache/$1"
    cp "$FT_BASE_PATH/$FT_LOAD_PATH/ft_dependencies.ft" ".ft/.cache/$1"
    mkdir -p ".ft/module"
    rm -rf "./ft/module/$1"
    mv ".ft/.cache/$1" ".ft/module"
    ;;
  *)
    echo "Error: Unrecognized module type: $(echo "$1" | head -c 1)"
    exit 1
    ;;
esac
