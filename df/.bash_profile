SHRC_SHELL=bash
SHRC_LOGIN=true

case "$-" in
	*i*) SHRC_INTERACTIVE=true ;;
esac

. "$HOME/.shrc.sh"
