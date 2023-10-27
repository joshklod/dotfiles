#!/bin/sh
#
# egrem.sh - Merge the specified commit, but
#            with the order of parents reversed

set -o errexit

target="$1"
shift

branch=$(git branch --show-current)
if [ -n "$branch" ]; then
	head=$branch
else
	head=$(git rev-parse HEAD)
fi

git checkout --detach "$target"
git merge --no-ff "$@" "$head"
if [ -n "$branch" ]; then
	git checkout -B "$branch"
fi
