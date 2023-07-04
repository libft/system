#!/bin/sh

set -e

(echo .ft/module/* | xargs -n 1 echo | sort) | while IFS= read -r line
do
  cat "$line/ft_recursive_peer_dependencies.ft"
done | sort | uniq | while IFS= read -r line
do
  if [ "$(echo ".ft/module/$line."*)" = ".ft/module/$line.*" ]; then
    echo "Error: peer dependency $line is not resolved."
    exit 1
  fi
done
