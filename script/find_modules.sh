#!/bin/sh

set -e

if [ -z "$FT_FIND_MODULES_PREFIX" ]; then
  FT_FIND_MODULES_NEXT_PREFIX=""
else
  FT_FIND_MODULES_NEXT_PREFIX="$FT_FIND_MODULES_PREFIX"
fi

echo */ | xargs -n 1 echo | sort | while IFS= read -r line
do
  if [ "$line" = "*/" ]; then
    exit 0
  fi
  line=$(printf "%s" "$line" | sed 's#/$##')
  if [ -f "$line/ft_dependencies.ft" ]; then
    case $line in
      h.*)
        FT_FIND_MODULES_NAME_WITHOUT_TYPE=${line#h.}
        case $FT_FIND_MODULES_NAME_WITHOUT_TYPE in
          *.*)
            1>&2 echo "[WARN] $line is not valid module name (header module cannot include edition)"
            ;;
          *)
            echo "./$FT_FIND_MODULES_PREFIX$line"
        esac
        ;;
      f.*)
        FT_FIND_MODULES_NAME_WITHOUT_TYPE=${line#f.}
        case $FT_FIND_MODULES_NAME_WITHOUT_TYPE in
          *.*.*)
            1>&2 echo "[WARN] $line is not valid module name (too many dots in module name)"
            ;;
          *)
            echo "./$FT_FIND_MODULES_PREFIX$line"
        esac
        ;;
      b.*)
        FT_FIND_MODULES_NAME_WITHOUT_TYPE=${line#b.}
        case $FT_FIND_MODULES_NAME_WITHOUT_TYPE in
          *.*.*)
            1>&2 echo "[WARN] $line is not valid module name (too many dots in module name)"
            ;;
          *)
            echo "./$FT_FIND_MODULES_PREFIX$line"
        esac
        ;;
    esac
  else
    case $0 in
      /*)
        (cd "$line" && FT_FIND_MODULES_PREFIX="$FT_FIND_MODULES_NEXT_PREFIX$line/" sh "$0")
        ;;
      find_modules.sh|./find_modules.sh)
        (cd "$line" && FT_FIND_MODULES_PREFIX="$FT_FIND_MODULES_NEXT_PREFIX$line/" sh "../find_modules.sh")
        ;;
      *)
        (cd "$line" && FT_FIND_MODULES_PREFIX="$FT_FIND_MODULES_NEXT_PREFIX$line/" sh "../$0")
        ;;
    esac
  fi
done
