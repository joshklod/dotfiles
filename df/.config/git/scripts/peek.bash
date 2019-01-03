#!/bin/bash
#
# peek.bash - Show file from another tree in editor

tree_ish=$1
    path=$2
  editor=$(git var GIT_EDITOR)

$editor <(git show "$tree_ish:$path")
