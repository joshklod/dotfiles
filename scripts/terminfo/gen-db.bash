#!/bin/bash
#
# gen-db.bash - Generate terminfo database

exec 3>&1

script_dir=$(dirname "$0")

cd "$script_dir"
rm -rf out

find src -name '*.ti' -print0 \
	| while IFS= read -rd $'\0'; do
		printf "Compiling '%s'...\n" "$script_dir/$REPLY"
		cat "$REPLY" >&4
	done 4>&1 1>&3 \
	| tic -sxo out -
