#!/bin/bash
#
# .bash_profile: Sourced in login shells

# source the users bashrc if it exists
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# Prepend personal bin directories to $PATH
[ -d "$HOME/.local/bin" ]   && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/bin" ]          && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/scripts" ]      && export PATH="$HOME/scripts:$PATH"

# Append portable tree bin directories to $PATH
if [ -d "$HOME/opt/tree" ]; then
	while IFS= read -r tree; do
		[ -z "$tree" ] && continue
		[ -d "$tree/bin" ] && export PATH="$PATH:$tree/bin"
	done <<-EOF
		$(find -L "$HOME/opt/tree" -mindepth 1 -maxdepth 1 -type d)
	EOF
fi

# Override INFOPATH to use automatic resolution
export INFOPATH='PATH:'

case "$(uname -s)" in
	CYGWIN*)
		# Include Windows Applications folder in PATH
		[ -d "/proc/cygdrive/c/Applications" ] &&
			export PATH="$PATH:/proc/cygdrive/c/Applications"

		# Ensure Cygwin paths precede all Windows paths
		unset first last
		OIFS="$IFS"; IFS=':'
		for dir in ${PATH}; do
			case "$dir" in
				/mnt/*|/cygdrive/*|/proc/cygdrive/*)   last="$last:$dir" ;;
				*)                                     first="$first:$dir" ;;
			esac
		done
		IFS="$OIFS"; unset OIFS
		PATH="${first:1}$last"
		;;
esac

# Source local .bash_profile if it exists
[ -f "$HOME/.local.bash_profile" ] && . "$HOME/.local.bash_profile"
