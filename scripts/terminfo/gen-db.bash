#!/bin/bash
#
# gen-db.bash - Generate terminfo database

script_dir=$(dirname "$0")

cd "$script_dir"
rm -rf out

files=`find src -name '*.ti'`

printf 'Compiling:'
echo "$files" | tr '\n' '\0' | xargs -0 printf " '%s'"
printf '\n'

echo "$files" | tr '\n' '\0' | xargs -0 cat | tic -sxo out -
