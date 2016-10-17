#!/bin/bash
#
# bash_aliases: Sourced in interactive shells

## Preferences
# ls defaults
alias ls='ls -C --color=auto --group-directories-first --human-readable'

# Interactive overwriting
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

## Shortcuts
# ls all
alias la='ls --almost-all'
# ls list
alias ll='ls -g --almost-all --no-group'

# View readonly
alias view='nano --view'

# Start X on default DISPLAY
alias x='export DISPLAY=:0.0; startxwin'

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
	while [ -z $path ]; do
		# If no directory specified, default to $HOME
		if [ $# -eq 0 ]; then
			path="$HOME"
			break
		fi
		case "$1" in
			-L|-P|-e|-@|-L@|-Pe|-P@|-eP|-@L|-@P)
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
	
	cd $cdargs "$path"
	# Print new working directory
	wdstr="${PWD/#$HOME/\~}:"
	[ $COLORS -ge 8 ] && wdstr="\e[1m$wdstr\e[0m" # Use color if available
	echo -e "$wdstr"
	ls $lsargs
}

# UART picocom shortcut
uart() {
	local arg="$1"
	local comport="/dev/ttyS$arg"
	picocom -b 115200 "$comport"
}

## Xterm-compatible only


## Cygwin only

# Windows GUI for updating Cygwin
alias cygupgrade='cygsetup --quiet-mode'
