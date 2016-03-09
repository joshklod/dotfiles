#!/bin/bash
#
# common bash_aliases: Sourced in interactive shells

# ls preferences
alias ls='ls -C --color=auto --group-directories-first --human-readable'

# ls shortcuts
alias la='ls --almost-all'
alias ll='ls -g --almost-all --no-group'

# Interactive overwriting
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

# cd and ls
cs() {
	cd $1; ls
}

# UART picocom shortcut
uart() {
	arg=$1
	comport="/dev/ttyS$arg"
	picocom -b 115200 $comport
}
