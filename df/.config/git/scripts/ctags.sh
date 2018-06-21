#!/bin/sh
#
# ctags.sh - Wrapper for ctags for use as a git hook

command -v ctags >/dev/null 2>&1 &&
ctags -R --exclude=.git --exclude=node_modules -f .tags . >/dev/null
