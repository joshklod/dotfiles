#!/bin/bash
#
# .bashrc: Sourced in interactive shells

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

## Script utilities

# Shortcut to check command existence
iscommand () { command -v "$@" >/dev/null 2>&1; }

# Check terminal for color support
if iscommand tput; then
	COLORS=$(tput colors) || COLORS=-1
	tput truecolor 2>/dev/null && export COLORTERM=truecolor
else
	COLORS=-1
fi
export COLORS

## Shell configuration
# Shell options
shopt -s extglob    # Interpret extended glob syntax
shopt -s dotglob    # Include .* files in glob
shopt -s globstar   # Enable 'dir/**/foo' syntax
shopt -s histappend # Don't clobber history from parallel shell sessions

# Environment variables
export EDITOR=$(command -v vim) # Use Vim as default editor
export HISTCONTROL=ignoredups # Ignore duplicates in history
export LESS='-R'              # Interpret ANSI escape sequences

# LS Colors
if [ $COLORS -ge 8 ] && iscommand dircolors; then
	if [ -f "$HOME/.dircolors" ]; then
		eval $(dircolors -b "$HOME/.dircolors")
	else
		eval $(dircolors -b)
	fi
fi

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
if [[ "$TERM" == @(xterm*|mintty) ]]; then
	settitle() { echo "\[\e]0;$1\a\]"; }
	PS1="$(settitle '\w')$PS1"
	unset settitle
fi

## Source aliases file
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

## Cleanup
unset iscommand
