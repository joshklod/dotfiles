#!/bin/bash
#
# common bashrc: Sourced in interactive shells

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Check terminal for color support
tmp=$(tput colors) && export COLORS=$tmp
unset tmp

## Shell configuration
# Shell options
shopt -s extglob # Interpret extended glob syntax
shopt -s dotglob # Include .* files in glob

# Environment variables
export HISTCONTROL=ignoredups # Ignore duplicates in history
export LESS='-R'              # Interpret ANSI escape sequences

# LS Colors
[ -f "$HOME/.dircolors" ] && eval $(dircolors "$HOME/.dircolors")

## Set prompt
if [ $COLORS -ge 8 ]; then
	blue='\[\e[34;22m\]'
	cyan='\[\e[36;22m\]'
	reset='\[\e[0m\]'
	
	# [blue]user@host [cyan]path
	# [cyan]$
	PS1="\n$blue\u@\h $cyan\w\n\$ $reset"
	PS2="$cyan> $reset"
	
	unset blue cyan reset
else
	# user@host path
	# $
	PS1='\n\u@\h \w\n\$ '
	PS2='> '
fi

# Set window title in xterm
if [[ "$TERM" = xterm* ]]; then
	settitle() { echo "\[\e]0;$1\a\]"; }
	PS1="$(settitle '\w')$PS1"
	unset settitle
fi

## Source aliases file
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
