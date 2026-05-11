## Script utilities

# Shortcut to check command existence
iscommand () { command -v "$@" >/dev/null 2>&1; }

# Terminal-specific hacks
if [ -n "$VIM_TERMINAL" ]; then
	# If the parent terminal supports truecolor, use the truecolor syntax that
	# Vim understands.  If not, leave $TERM alone.  Programs won't send
	# truecolor sequences, and Vim will handle everything correctly.
	if tput truecolor 2>/dev/null; then
		export TERM=xterm-semitruecolor # Vim's terminal acts like this
	fi
	unset VIM_TERMINAL # This is misleading if inherited by another terminal
elif [ -n "$WT_SESSION" ]; then
	# Windows Terminal
	export TERM=xterm-truecolor
fi

# Check terminal for color support
COLORS=$(tput colors) || COLORS=-1
export COLORS
if tput truecolor 2>/dev/null; then
	export COLORTERM=truecolor
else
	unset COLORTERM
fi

# Environment variables
export AUTOPAGE_CUTOFF='50%'
export EDITOR=$(command -v vim) # Use Vim as default editor
export GNUMAKEFLAGS='--output-sync=target --no-print-directory'
export HISTCONTROL=ignoredups # Ignore duplicates in history
export LESS='-iR'               # Interpret ANSI escape sequences
export MAKEFLAGS='--jobs=4'

# LS Colors
if [ $COLORS -ge 8 ] && iscommand dircolors; then
	if [ -f "$HOME/.dircolors" ]; then
		eval $(dircolors -b "$HOME/.dircolors")
	else
		eval $(dircolors -b)
	fi
fi

## Source aliases file
[ -f "$SHRC_DIR/aliases.sh" ] && . "$SHRC_DIR/aliases.sh"

## Cleanup
unset iscommand
