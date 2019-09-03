#!/bin/bash
#
# gen-db.bash - Generate terminfo database

xargs_n () {
	tr '\n' '\0' | xargs -0 "$@"
}

script_dir=`dirname "$0"`

cd "$script_dir"
rm -rf out

files=`find src -name '*.ti'`

printf 'Compiling:'
echo "$files" | xargs_n printf " '%s'"
printf '\n'

echo "$files" | xargs_n cat | tic -sxo out -
