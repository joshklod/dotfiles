#!/bin/bash
#
# Cygwin bash_profile: Sourced in login shells

# Source common bash_profile
source "${HOME}/repos/dotfiles/.bash_profile"

# Include Windows Applications folder in PATH
PATH="${PATH}:/cygdrive/c/Applications"

# Include Cygwin-specific bin in PATH
PATH="${HOME}/gdbash/bin/cygwin:$PATH"

# Include Cygwin-specific man in MANPATH
MANPATH="${HOME}/gdbash/bin/cygwin/man:$MANPATH"
