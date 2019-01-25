#!/bin/bash
#
# gen-db.bash - Generate terminfo database

script_dir=$(dirname "$0")

cd "$script_dir"

while IFS= read -rd $'\0'; do
	printf "Compiling '%s'...\n" "$script_dir/$REPLY"
	tic -xo ~/.terminfo "$REPLY"
done < <(find src -name '*.terminfo' -print0)
