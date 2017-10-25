#!/bin/sh
#
# cat.sh - Show output of git command inline (no pager) with color

command="$1"
shift

git "$command" --color "$@" | cat
