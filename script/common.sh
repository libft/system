#!/bin/sh

[ -d "$FT_BASE_PATH" ] || {
  FT_BASE_PATH=$(pwd)
  while [ "$FT_BASE_PATH" != "/" ] && [ ! -f ".ft_base_path" ]
  do
    FT_BASE_PATH=$(cd "$FT_BASE_PATH" && cd .. && pwd)
  done
  if [ ! -f "$FT_BASE_PATH/.ft_base_path" ]; then
    exit 1
  fi
  export FT_BASE_PATH
}

FT_BASE_PATH="$(cd "$FT_BASE_PATH" && pwd)"
export FT_BASE_PATH
