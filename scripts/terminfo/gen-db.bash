#!/bin/bash
#
# gen-db.bash - Generate terminfo database

script_dir=$(dirname "$0")

cd "$script_dir"
rm -rf out

while IFS= read -rd $'\0'; do
	printf "Compiling '%s'...\n" "$script_dir/$REPLY"
	tic -sxo out "$REPLY"
done < <(find src -name '*.ti' -print0)
