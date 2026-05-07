# .shrc.sh

# Set by shell-specific initialization scripts
: ${SHRC_SHELL:=sh}
: ${SHRC_COMMON=sh}
: ${SHRC_LOGIN=}
: ${SHRC_LOGOUT=}
: ${SHRC_INTERACTIVE=}

# Generic configuration
: ${SHRC_DIR:=${XDG_CONFIG_HOME:-$HOME/.config}/shrc}
export SHRC_DIR

shrc_source () {
	[ -f "$1" ] && . "$1"
}

shrc_source_rc () {
	if [ -n "$SHRC_COMMON" ] && [ "$SHRC_COMMON" != "$SHRC_SHELL" ]; then
		shrc_source "$SHRC_DIR/$1.$SHRC_COMMON"
	fi
	shrc_source "$SHRC_DIR/$1.$SHRC_SHELL"
}

if [ -n "$SHRC_LOGOUT" ]; then
	shrc_source_rc 'local/logout'
	shrc_source_rc 'logout'
	shrc_source_rc 'local/post-logout'
elif [ -z "${_SHRC_DONE-}" ]; then
	shrc_source_rc 'local/first'
	shrc_source_rc 'pre'
	shrc_source_rc 'local/pre'
	if [ -n "$SHRC_LOGIN" ]; then
		shrc_source_rc 'login'
		shrc_source_rc 'local/login'
	fi
	if [ -n "$SHRC_INTERACTIVE" ]; then
		shrc_source_rc 'interactive'
		shrc_source_rc 'local/interactive'
	fi
	shrc_source_rc 'always'
	shrc_source_rc 'local/always'

	_SHRC_DONE=true
fi

unset SHRC_SHELL SHRC_COMMON SHRC_LOGIN SHRC_LOGOUT SHRC_INTERACTIVE
unset shrc_source shrc_source_rc
