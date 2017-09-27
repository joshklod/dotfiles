#!/bin/bash
#
# .bash_aliases: Sourced in interactive shells

# Necessary for case statement in cs()
shopt -s extglob

## Preferences
# Command defaults
alias ls='ls -C --color=auto --dereference-command-line \
          --group-directories-first --human-readable'
alias grep='grep --color=auto'
alias picocom='picocom -b 19200'
alias bc='bc -l'

# Interactive overwriting
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

## Shortcuts
# ls all
alias la='ls --almost-all'
# ls list
alias ll='ls -g --no-group'
# ls all list
alias lal='ls -g --almost-all --no-group'
# ls long list
alias lll='ls -l'
# ls all long list
alias lall='ls -l --all'
alias llal='lall'

# Go back to previous directory
alias back='cd "$OLDPWD"'

# Print $PATH in a human-readable format
alias path='echo $PATH | tr : \\n'

# Enjoy!
alias lulz='cat /dev/urandom | hexdump -C |
            GREP_COLORS="mt=1;32" grep -E "[[:xdigit:]]{4}0000"'

# mkdir and cd
mkcd() { mkdir "$1" && cd "$1"; }

# cd and ls
cs() {
	# Declare local variables
	local path
	local cdargs
	local lsargs
	local wdstr
	
	# Parse command line parameters
	# Args before path assumed to be for cd it exists
	# Loop until path is found
	while [ -z "$path" ]; do
		# If no directory specified, default to $HOME
		if [ $# -eq 0 ]; then
			path="$HOME"
			break
		fi
		case "$1" in
			-+([LPe@]) ) cdargs="$cdargs $1" ;;
			-*         ) lsargs="$lsargs $1" ;;
			*          ) path="$1"           ;;
		esac
		shift
	done
	# Args after path assumed to be for ls
	lsargs="$lsargs $@"
	
	# Change directory
	cd $cdargs "$path" || return 1
	# Print new working directory
	wdstr="$(pwd | sed "s/^${HOME//\//\\\/}\b/~/"):"
	[ $COLORS -ge 8 ] && wdstr="\e[1m$wdstr\e[0m" # Use color if available
	echo -e "$wdstr"
	# List new directory contents
	ls $lsargs
}
