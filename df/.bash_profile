#!/bin/bash
#
# .bash_profile: Sourced in login shells

# source the users bashrc if it exists
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# Prepend personal bin directories to $PATH
[ -d "$HOME/bin" ]       && PATH="$HOME/bin:$PATH"
[ -d "$HOME/scripts" ]   && PATH="$HOME/scripts:$PATH"

# Set MANPATH so it includes users' private man if it exists
[ -d "$HOME/man" ] && MANPATH="$HOME/man:$MANPATH"

# Set INFOPATH so it includes users' private info if it exists
[ -d "$HOME/info" ] && INFOPATH="$HOME/info:$INFOPATH"

case "$(uname -s)" in
	CYGWIN*)
		# Include Windows Applications folder in PATH
		[ -d "/proc/cygdrive/c/Applications" ] && PATH="$PATH:/proc/cygdrive/c/Applications"
		;;
esac

# Source local .bash_profile if it exists
[ -f "$HOME/.local.bash_profile" ] && source "$HOME/.local.bash_profile"
