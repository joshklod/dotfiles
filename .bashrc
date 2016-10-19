#!/bin/bash
#
# common bashrc: Sourced in interactive shells

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell options
shopt -s extglob # Interpret extended glob syntax
shopt -s dotglob # Include .* files in glob

# Ignore duplicates in history
HISTCONTROL=ignoredups

# Check terminal for color support
tmp=$(tput colors) && export COLORS=$tmp

# Source aliases file
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

## Set prompt
if [ $COLORS -ge 8 ]; then
	# [blue]user@host [cyan]path
	# [cyan]$
	PS1='\n\[\e[34m\]\u@\h \[\e[36m\]\w\n\$\[\e[0m\] '
	PS2='\[\e[36m\]>\[\e[0m\] '
else
	# user@host path
	# $
	PS1='\n\u@\h \w\n\$ '
	PS2='> '
fi

# Set window title in xterm
[[ "$TERM" = xterm* ]] && PS1="\[\e]0;\w\a\]$PS1"

# Clear temporary variables
unset tmp
