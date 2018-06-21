#!/bin/sh
#
# revlog.sh - Generate revision log from git history

# Shortcut to check command existence
iscommand() { command -v "$@" >/dev/null 2>&1; }

if iscommand unix2dos; then
	eol=unix2dos
else
	eol=cat
fi

git mlog --date=short --pretty=tformat:'%x09%ad - %s' "$@" | $eol
