#!/bin/sh
#
# cptree.sh - Copies the tree from the specified commit and makes the worktree
#             and index match it exactly

commit="$1"

# Delete everything first, as checkout does not do this
git rm -qrf .
# Get everything from the specified commit
git checkout "$commit" -- .
