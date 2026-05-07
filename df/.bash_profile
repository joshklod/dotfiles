SHRC_SHELL=bash
SHRC_LOGIN=true

case "$-" in
	*i*) SHRC_INTERACTIVE=true ;;
esac

# Make non-interactive non-login subshells work with shrc
export BASH_ENV="$HOME/.bashrc"

. "$HOME/.shrc.sh"
