#!/bin/bash
#
# bash_aliases: Sourced in interactive shells

# ls preferences
alias ls='ls -C --color=auto --group-directories-first --human-readable'

# ls shortcuts
alias la='ls --almost-all'
alias ll='ls -g --almost-all --no-group'

# Interactive overwriting
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

# View readonly
alias view='nano --view'

# Start X on default DISPLAY
alias x='export DISPLAY=:0.0; startxwin'

# cd and ls
cs() {
	# Parse command line parameters
	# Args before path assumed to be for cd it exists
	# Loop until path is found
	while [ -z $dir ]; do
		# If no directory specified, default to $HOME
		if [ $# -eq 0 ]; then
			local dir="$HOME"
			break
		fi
		case "$1" in
			-L|-P|-e|-@|-L@|-Pe|-P@|-eP|-@L|-@P)
				local cdargs="$cdargs $1"
				;;
			-*)
				local lsargs="$lsargs $1"
				;;
			*)
				local dir="$1"
				;;
		esac
		shift
	done
	# Args after path assumed to be for ls
	local lsargs="$lsargs $@"
	
	cd $cdargs "$dir"
	# Check terminal for color support
	if [[ $(tput colors) ]] && [[ $(tput colors) -ge 8 ]]; then
		local wdstr="\e[1m$PWD:\e[0m"
	else
		local wdstr="$PWD:"
	fi
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
