#!/bin/sh

set -e

sh "$(dirname "$0")/find_tests.sh" | sort | while IFS= read -r line
do
  echo "${line##*/}=${line#./}"
done
