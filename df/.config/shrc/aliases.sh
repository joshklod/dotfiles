## Preferences
# Command defaults
alias ls='ls -C --color=auto --dereference-command-line \
          --group-directories-first --human-readable'
alias grep='grep --color=auto'
alias picocom='picocom -b 19200'
alias bc='bc -l'
alias rsync='rsync -hh --info=progress2,stats'

# Interactive overwriting
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

## Shortcuts
# ls all
alias la='ls --almost-all'
# ls list
alias ll='ls -g --no-group'
# ls all list
alias lal='ls -g --almost-all --no-group'
# ls long list
alias lll='ls -l'
# ls all long list
alias lall='ls -l --all'
alias llal='lall'

# Go back to previous directory
alias back='cd "$OLDPWD"'

# One-line mathematical calculation
calc () { echo "$*" | bc; }

# Print $PATH in a human-readable format
alias path='echo $PATH | tr : \\n'

# Enjoy!
alias lulz='cat /dev/urandom | hexdump -C |
            GREP_COLORS="mt=1;32" grep -E "[[:xdigit:]]{4}0000"'

# mkdir and cd
mkcd() { mkdir "$1" && cd "$1"; }

case "$(uname -s)" in
	CYGWIN*)
		# Open Explorer window in current directory
		alias exp='explorer .'

		# Start X Server in the background silently
		alias silentx='log --stderr startxwin'

		# Automatically set $DISPLAY if unset
		alias auto-disp='[ -z "$DISPLAY" ] && export DISPLAY=:0.0'
		# Start X programs with default DISPLAY
		alias x='auto-disp; silentx'
		alias gvim='auto-disp; gvim'

		# Executes command in a separate window
		win () { mintty "$@" & }

		# Windows GUI for updating Cygwin
		alias cygupdate='curl -o "/proc/cygdrive/c/applications/cygwin-setup.exe" https://cygwin.com/setup-x86_64.exe'
		alias cygupgrade='cygsetup --quiet-mode'
		;;
esac

# WSL
if [ -n "$(wslinfo --version 2>/dev/null)" ]; then
	# Open Explorer window in current directory
	alias exp='explorer.exe .'

	# Execute command in a new terminal window
	win() {
		wt.exe -w new -d "$(wslpath -w "$PWD")" \
			wsl.exe -d "$WSL_DISTRO_NAME" -e \
				sh -ilc "$(printf '%q ' "$@")"
	}

	# Execute command in a new terminal tab
	tab() {
		wt.exe -w last -d "$(wslpath -w "$PWD")" \
			wsl.exe -d "$WSL_DISTRO_NAME" -e \
				sh -ilc "$(printf '%q ' "$@")"
	}
fi
