#!/bin/bash
#
# gen-db.bash - Generate terminfo database

exec 3>&1

script_dir=$(dirname "$0")

cd "$script_dir"
rm -rf out

printf 'Compiling:'
files=`find src -name '*.ti' -print0 | tee >(xargs -0 printf " '%s'" >&3) \
		| tr '\0' '\n'`
printf '\n'

echo "$files" | tr '\n' '\0' | xargs -0 cat | tic -sxo out -
