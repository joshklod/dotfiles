SHRC_SHELL=bash
SHRC_LOGOUT=true

case "$-" in
	*i*) SHRC_INTERACTIVE=true ;;
esac

. "$HOME/.shrc.sh"
