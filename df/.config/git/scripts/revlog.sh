#!/bin/sh
#
# revlog.sh - Generate revision log from git history

# Shortcut to check command existence
iscommand() { command -v "$@" >/dev/null 2>&1; }

if iscommand unix2dos; then
	eol='unix2dos -f'
else
	eol=cat
fi

# Check whether git output should be colored
if git config --get-colorbool color.ui; then
	color=always
else
	color=never
fi

git -c color.ui=$color mlog --pretty=tformat:'%x09%as - %s' "$@" | $eol
