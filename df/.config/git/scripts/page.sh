#!/bin/sh
#
# page.sh - Show output of git command in a pager with color

git -c color.ui=always "$@" | less
