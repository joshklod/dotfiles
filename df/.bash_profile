#!/bin/bash
#
# .bash_profile: Sourced in login shells

# source the users bashrc if it exists
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# Prepend personal bin directories to $PATH
[ -d "$HOME/bin" ]       && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/scripts" ]   && export PATH="$HOME/scripts:$PATH"

# Override INFOPATH to use automatic resolution
export INFOPATH='PATH:'

case "$(uname -s)" in
	CYGWIN*)
		# Include Windows Applications folder in PATH
		[ -d "/proc/cygdrive/c/Applications" ] &&
			export PATH="$PATH:/proc/cygdrive/c/Applications"
		;;
esac

# Source local .bash_profile if it exists
[ -f "$HOME/.local.bash_profile" ] && source "$HOME/.local.bash_profile"
