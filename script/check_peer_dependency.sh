#!/bin/sh

set -e

find ".ft/module" -depth 1 | while IFS= read -r line
do
  cat "$line/ft_recursive_peer_dependencies.ft"
done | sort | uniq | while IFS= read -r line
do
  if [ -z "$(find ".ft/module" -depth 1 -name "$line.*")" ]; then
    echo "Error: peer dependency $line is not resolved."
    exit 1
  fi
done
