#!/bin/bash
#
# common bashrc: Sourced in interactive shells

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Source aliases file
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

## Set prompt
# Check terminal for color support
colors=$(tput colors)
if [[ $colors ]] && [[ $colors -ge 8 ]]; then
	# [blue]user@host [cyan]path
	# [cyan]$
	prompt='\n\[\e[34m\]\u@\h \[\e[36m\]\w\[\e[36m\]\n\$\[\e[0m\] '
else
	# user@host path
	# $
	prompt='\n\u@\h \w\n\$ '
fi

# Set window title in xterm
case "$TERM" in
	xterm*)
		# Terminal control sequence to set window title
		PS1="\[\e]0;\w\a\]$prompt"
		;;
	*)
		PS1=$prompt
esac
unset prompt
