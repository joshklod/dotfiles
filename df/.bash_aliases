#!/bin/bash
#
# .bash_aliases: Sourced in interactive shells

# Necessary for case statement in cs()
shopt -s extglob

## Preferences
# Command defaults
alias ls='ls -C --color=auto --dereference-command-line --group-directories-first --human-readable'
alias grep='grep --color=auto'

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

# Run command with output redirected to logfile
log() {
	# Default directory to contain logfile
	[ -z "$LOGDIR" ] && local LOGDIR="$HOME/.logs"
	# Create directory if it does not exist, or default to $HOME
	[ ! -d "$LOGDIR" ] && { mkdir "$LOGDIR" || LOGDIR="$HOME"; }
	# Name of logfile is name of command
	local logfile="$LOGDIR/$1.log";
	# Append a header indicating start of new log
	echo -e "\n\n################ LOG $(date) ###############\n" >> "$logfile"
	# Escape command line arguments
	local command=""
	for arg in "$@"; do command="$command'${arg//\'/\'\"\'\"\'}' "; done
	# Execute command with redirected output
	eval "$command >> $logfile 2>&1"
	# Timestamp end of program execution
	echo -e "\n######## Program Terminated $(date) ########" >> "$logfile"
}

# Enjoy!
alias lulz='cat /dev/urandom | hexdump -C | grep -E "[[:xdigit:]]{4}0000"'

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
			-+([LPe@]) )
				cdargs="$cdargs $1"
				;;
			-*)
				lsargs="$lsargs $1"
				;;
			*)
				path="$1"
				;;
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
