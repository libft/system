#!/bin/sh

set -e

. "$(dirname "$0")/common.sh"

FT_LOAD_PATH="$(grep "$1=" < "$FT_BASE_PATH/.ft/.cache/module_list.properties")"
if [ -z "$FT_LOAD_PATH" ]; then
  echo "Error: failed to find module \"$1\""
  exit 1
fi
FT_LOAD_PATH=${FT_LOAD_PATH#*=}

rm -rf -- ".ft/.cache/$1"
trap 'rm -rf -- ".ft/.cache/$1"' EXIT
mkdir -p ".ft/.cache/$1"

case $1 in
  h.*)
    FT_LOAD_NAME="${1#h.}"
    cp "$FT_BASE_PATH/$FT_LOAD_PATH/$FT_LOAD_NAME.h" "$FT_BASE_PATH/$FT_LOAD_PATH/ft_dependencies.ft" ".ft/.cache/$1"
    ;;
  f.*)
    FT_LOAD_NAME_AND_EDITION="${1#f.}"
    FT_LOAD_NAME="${FT_LOAD_NAME_AND_EDITION%%.*}"
    cp "$FT_BASE_PATH/$FT_LOAD_PATH/$FT_LOAD_NAME.c" "$FT_BASE_PATH/$FT_LOAD_PATH/ft_dependencies.ft" ".ft/.cache/$1"
    [ ! -f "$FT_BASE_PATH/$FT_LOAD_PATH/ft_peer_dependencies.ft" ] || cp "$FT_BASE_PATH/$FT_LOAD_PATH/ft_peer_dependencies.ft" ".ft/.cache/$1"
    [ -f "$FT_BASE_PATH/$FT_LOAD_PATH/ft_peer_dependencies.ft" ] || touch ".ft/.cache/$1"
    ;;
  b.*)
    FT_LOAD_NAME_AND_EDITION="${1#b.}"
    FT_LOAD_NAME="${FT_LOAD_NAME_AND_EDITION%%.*}"
    cp "$FT_BASE_PATH/$FT_LOAD_PATH/ft_dependencies.ft" ".ft/.cache/$1"
    ;;
  *)
    echo "Error: Unrecognized module type: ${1%%.*}"
    exit 1
    ;;
esac

cp ".ft/.cache/$1/ft_dependencies.ft" ".ft/.cache/$1/ft_recursive_dependencies.ft"
touch ".ft/.cache/$1/ft_recursive_peer_dependencies.ft"
[ ! -f ".ft/.cache/$1/ft_peer_dependencies.ft" ] || cp ".ft/.cache/$1/ft_peer_dependencies.ft" ".ft/.cache/$1/ft_recursive_peer_dependencies.ft"
cat ".ft/.cache/$1/ft_dependencies.ft" | while IFS= read -r line
do
  cat ".ft/module/$line/ft_recursive_dependencies.ft" >> ".ft/.cache/$1/ft_recursive_dependencies.ft"
  cat ".ft/module/$line/ft_recursive_peer_dependencies.ft" >> ".ft/.cache/$1/ft_recursive_peer_dependencies.ft"
done
mv ".ft/.cache/$1/ft_recursive_dependencies.ft" ".ft/.cache/$1/ft_recursive_dependencies.ft.tmp"
mv ".ft/.cache/$1/ft_recursive_peer_dependencies.ft" ".ft/.cache/$1/ft_recursive_peer_dependencies.ft.tmp"
cat ".ft/.cache/$1/ft_recursive_dependencies.ft.tmp" | sort | uniq > ".ft/.cache/$1/ft_recursive_dependencies.ft"
cat ".ft/.cache/$1/ft_recursive_peer_dependencies.ft.tmp" | sort | uniq > ".ft/.cache/$1/ft_recursive_peer_dependencies.ft"
rm ".ft/.cache/$1/ft_recursive_dependencies.ft.tmp"
rm ".ft/.cache/$1/ft_recursive_peer_dependencies.ft.tmp"

mkdir -p ".ft/module"
rm -rf ".ft/module/$1"
mv ".ft/.cache/$1" ".ft/module"
