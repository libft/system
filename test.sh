#!/bin/sh

set -e

rm -rf tmp
trap 'rm -rf -- tmp' EXIT
mkdir tmp
cd tmp
FT_BASE_PATH=.. sh ../script/load_module_recursive.sh b.sample
FT_BASE_PATH=.. sh ../script/build_home.sh
(cd .ft/home && FT_BASE_PATH=../../.. make)
