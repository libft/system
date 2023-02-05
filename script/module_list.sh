#!/bin/sh

set -e

sh "$(dirname "$0")/find_modules.sh" | while IFS= read -r line
do
  echo "${line##*/}=${line#./}"
done
