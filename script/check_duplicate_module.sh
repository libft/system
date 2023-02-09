#!/bin/sh

set -e

find ".ft/module" -depth 1 | cut -c 12- | while IFS="." read -r module_type module_name unused
do
  if [ "$(find ".ft/module" -depth 1 | cut -c 12- | grep -cE "^$module_type\\.$module_name\$|^$module_type\\.$module_name\\.")" -ne "1" ]; then
    echo "Error: module $module_type.$module_name is resolved multiple times"
    find ".ft/module" -depth 1 | cut -c 12- | grep -E "^$module_type\\.$module_name\$|^$module_type\\.$module_name\\." | sort
    exit 1
  fi
done
