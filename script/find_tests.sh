#!/bin/sh

set -e

(
find . -type d -name test | grep -v /\\. | while IFS= read -r line
do
  FT_FIND_TESTS_NAME=${line%/test}
  echo "${FT_FIND_TESTS_NAME#./}=$line"
done &&
find . -type d -name tests | grep -v /\\. | while IFS= read -r line1
do
  FT_FIND_TESTS_NAME_PREFIX=${line1%/tests}
  (cd "$line1" && echo */ | xargs -n 1 echo | sort) | while IFS= read -r line2
  do
    echo "${FT_FIND_TESTS_NAME_PREFIX#./}/$line2=$line1/$line2"
  done
done
) | sort
