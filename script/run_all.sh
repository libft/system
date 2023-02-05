#!/bin/sh

set -e

sh "$(dirname "$0")/find_tests.sh" | sort | while IFS="=" read -r name path
do
  (cd "$path" && FT_TEST_NAME="$name" ${MAKE-make} "$1")
done
