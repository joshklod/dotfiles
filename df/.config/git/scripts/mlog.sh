#!/bin/sh
#
# mlog.sh - Magic log - `git log --graph` with columns aligned

# Shortcut to check command existence
iscommand() { command -v "$@" >/dev/null 2>&1; }

tab=$(printf '\t')

# Check whether git output should be colored
if git config --get-colorbool color.ui; then
	color=true
else
	color=false
fi

if [ "$color" = 'true' ]; then
	color_cmd='-c color.ui=always'
fi

if iscommand column && [ "$color" = 'false' ]; then
	filter="sed -e 's/ *\($tab\|$\)/\1/g' | column -t -s '$tab'"
elif iscommand colorcolumn; then
	filter="sed -e 's/ *\($tab\|$\)/\1/g' | colorcolumn FS='$tab' OFS='  '"
elif iscommand expand && [ "$color" = 'false' ]; then
	filter=expand
else
	filter=cat
fi

git $color_cmd log --graph "$@" | eval "$filter"
