#!/bin/sh

set -e

(cd ".ft/module" && echo */ | xargs -n 1 echo | sort | sed 's#/$##') | while IFS="." read -r module_type module_name _unused
do
  if [ "$( (cd ".ft/module" && echo */ | xargs -n 1 echo | sort | sed 's#/$##') | grep -cE "^$module_type\\.$module_name\$|^$module_type\\.$module_name\\.")" -ne "1" ]; then
    echo "Error: module $module_type.$module_name is resolved multiple times"
    (cd ".ft/module" && echo */ | xargs -n 1 echo | sort | sed 's#/$##') | grep -E "^$module_type\\.$module_name\$|^$module_type\\.$module_name\\."
    exit 1
  fi
done
