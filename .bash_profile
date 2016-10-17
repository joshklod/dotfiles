#!/bin/bash
#
# bash_profile: Sourced in login shells

# source the users bashrc if it exists
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# Set PATH so it includes user's private bin if it exists
[ -d "${HOME}/bin" ] && PATH="$HOME/bin:$PATH"

# Set MANPATH so it includes users' private man if it exists
[ -d "$HOME/man" ] && MANPATH="$HOME/man:$MANPATH"

# Set INFOPATH so it includes users' private info if it exists
[ -d "$HOME/info" ] && INFOPATH="$HOME/info:$INFOPATH"

# Include Google Drive bin in PATH
[ -d "$HOME/gdbash/bin" ] && PATH="$HOME/gdbash/bin:$PATH"

# Include Google Drive man in MANPATH
[ -d "$HOME/gdbash/bin/man" ] && MANPATH="$HOME/gdbash/bin/man:$MANPATH"


## Cygwin only

# Include Windows Applications folder in PATH
[ -d "/cygdrive/c/Applications" ] && PATH="$PATH:/cygdrive/c/Applications"

# Include Cygwin-specific bin in PATH
[ -d "$HOME/gdbash/bin/cygwin" ] && PATH="$HOME/gdbash/bin/cygwin:$PATH"

# Include Cygwin-specific man in MANPATH
[ -d "$HOME/gdbash/bin/cygwin/man" ] && \
MANPATH="$HOME/gdbash/bin/cygwin/man:$MANPATH"
