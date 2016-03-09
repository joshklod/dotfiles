#!/bin/bash
#
# common bashrc: Sourced in interactive shells

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Source aliases file
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi
