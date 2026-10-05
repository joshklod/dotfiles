#!/bin/sh
#
# word-textconv.sh - Wrapper for docx2txt for use as a git diff filter

iscommand () {
	command -v "$@" >/dev/null 2>&1
}

if iscommand docx2txt.pl; then
	docx2txt.pl "$1" -
elif iscommand unzip; then
	unzip -p "$1"
else
	cat -v "$1"
fi
