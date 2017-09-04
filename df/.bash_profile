#!/bin/bash
#
# .bash_profile: Sourced in login shells

# source the users bashrc if it exists
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# Set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# Set MANPATH so it includes users' private man if it exists
[ -d "$HOME/man" ] && MANPATH="$HOME/man:$MANPATH"

# Set INFOPATH so it includes users' private info if it exists
[ -d "$HOME/info" ] && INFOPATH="$HOME/info:$INFOPATH"

# Add ~/scripts to $PATH if it exists
[ -d "$HOME/scripts" ] && PATH="$HOME/scripts:$PATH"
