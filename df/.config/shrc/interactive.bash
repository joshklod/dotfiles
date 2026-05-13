## Shell configuration
# Shell options
shopt -s checkjobs  # Don't exit if there are running jobs
shopt -s extglob    # Interpret extended glob syntax
shopt -s dotglob    # Include .* files in glob
shopt -s globstar   # Enable 'dir/**/foo' syntax
shopt -s histappend # Don't clobber history from parallel shell sessions

## Set prompt
if [ $COLORS -ge 8 ]; then
	octal_escape () (
		LC_ALL=C
		while IFS='' read -r -d '' -n 1 char; do
			ord=$(printf '%d' "'$char")
			if [ 32 -le "$ord" ] && [ "$ord" -lt 127 ]; then
				printf '%c' "$char"
			else
				printf '\\%03o' "$ord"
			fi
		done
	)

	blue="\[$({ tput setaf 4 || tput setf 1; } | octal_escape)\]"
	cyan="\[$({ tput setaf 6 || tput setf 3; } | octal_escape)\]"
	reset="\[$(tput sgr0 | octal_escape)\]"
	
	# [blue]user@host [cyan]path
	# [cyan]$
	PS1="$reset\n$blue\u@\h $cyan\w$reset\n$cyan\$ $reset"
	PS2="$reset$cyan> $reset"
	
	unset blue cyan reset
	unset -f octal_escape
else
	# user@host path
	# $
	PS1='\n\u@\h \w\n\$ '
	PS2='> '
fi

# Set window title in xterm
if [[ "$TERM" == @(xterm*|mintty) ]]; then
	settitle() { echo "\[\e]0;$1\a\]"; }
	PS1="$(settitle '\w')$PS1"
	unset -f settitle
fi

## Source aliases file
[ -f "$SHRC_DIR/aliases.bash" ] && source "$SHRC_DIR/aliases.bash"
