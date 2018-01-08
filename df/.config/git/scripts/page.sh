#!/bin/sh
#
# page.sh - Show output of git command in a pager with color

command="$1"
shift

git "$command" --color "$@" | less
