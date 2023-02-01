#!/bin/bash
#
# .bash_profile: Sourced in login shells

# source the users bashrc if it exists
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# Prepend personal bin directories to $PATH
[ -d "$HOME/bin" ]       && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/scripts" ]   && export PATH="$HOME/scripts:$PATH"

# Append portable tree bin directories to $PATH
if [ -d "$HOME/opt/tree" ]; then
	while IFS= read -rd '' tree; do
		[ -d "$tree/bin" ] && export PATH="$PATH:$tree/bin"
	done < <(find -L "$HOME/opt/tree" -mindepth 1 -maxdepth 1 -type d -print0)
fi

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
