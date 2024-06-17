#!/bin/bash
#
# .bashrc: Sourced in interactive shells

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

## Script utilities

# Shortcut to check command existence
iscommand () { command -v "$@" >/dev/null 2>&1; }

# Fix $TERM inside a Vim Terminal
if [ -n "$VIM_TERMINAL" ]; then
	# If the parent terminal supports truecolor, use the truecolor syntax that
	# Vim understands.  If not, leave $TERM alone.  Programs won't send
	# truecolor sequences, and Vim will handle everything correctly.
	if tput truecolor 2>/dev/null; then
		export TERM=xterm-semitruecolor # Vim's terminal acts like this
	fi
	unset VIM_TERMINAL # This is misleading if inherited by another terminal
fi

# Check terminal for color support
if iscommand tput; then
	COLORS=$(tput colors) || COLORS=-1
	if tput truecolor 2>/dev/null; then
		export COLORTERM=truecolor
	else
		unset COLORTERM
	fi
else
	COLORS=-1
fi
export COLORS

## Shell configuration
# Shell options
shopt -s checkjobs  # Don't exit if there are running jobs
shopt -s extglob    # Interpret extended glob syntax
shopt -s dotglob    # Include .* files in glob
shopt -s globstar   # Enable 'dir/**/foo' syntax
shopt -s histappend # Don't clobber history from parallel shell sessions

# Environment variables
export AUTOPAGE_CUTOFF='50%'
export EDITOR=$(command -v vim) # Use Vim as default editor
export GNUMAKEFLAGS='--output-sync=target --no-print-directory'
export HISTCONTROL=ignoredups # Ignore duplicates in history
export LESS='-iR'               # Interpret ANSI escape sequences
export MAKEFLAGS='--jobs=4'

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
	octal_escape () (
		LC_ALL=C
		while IFS='' read -r -d '' -n 1 char; do
			ord=$(printf '%d' "'$char")
			if [ 32 -le "$ord" ] && [ "$ord" -lt 127 ]; then
				printf '%c' "$char"
			else
				printf '\\%03o' "$ord"
			fi
		done
	)

	blue="\[$({ tput setaf 4 || tput setf 1; } | octal_escape)\]"
	cyan="\[$({ tput setaf 6 || tput setf 3; } | octal_escape)\]"
	reset="\[$(tput sgr0 | octal_escape)\]"
	
	# [blue]user@host [cyan]path
	# [cyan]$
	PS1="$reset\n$blue\u@\h $cyan\w$reset\n$cyan\$ $reset"
	PS2="$reset$cyan> $reset"
	
	unset octal_escape blue cyan reset
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

## Source local .bashrc if it exists
[ -f "$HOME/.local.bashrc" ] && source "$HOME/.local.bashrc"

## Cleanup
unset iscommand
