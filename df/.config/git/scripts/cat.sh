#!/bin/sh
#
# cat.sh - Show output of git command inline (no pager) with color

git -c color.ui=always "$@" | cat
