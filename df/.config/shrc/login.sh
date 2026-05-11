# Make non-login POSIX shells work with shrc
export ENV="$HOME/.shrc.sh"

# Make non-interactive non-login Bash shells work with shrc
export BASH_ENV="$HOME/.bashrc"

# Prepend personal bin directories to $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/scripts:$PATH"

# Append portable tree bin directories to $PATH
if [ -d "$HOME/opt/tree" ]; then
	while IFS= read -r tree; do
		[ -z "$tree" ] && continue
		export PATH="$PATH:$tree/bin"
	done <<-EOF
		$(find -L "$HOME/opt/tree" -mindepth 1 -maxdepth 1 -type d)
	EOF
fi

# Override INFOPATH to use automatic resolution
export INFOPATH='PATH:'

case "$(uname -s)" in
	CYGWIN*)
		# Include Windows Applications folder in PATH
		export PATH="$PATH:/proc/cygdrive/c/Applications"

		# Ensure Cygwin paths precede all Windows paths
		unset first last
		OIFS="$IFS"; IFS=':'
		for dir in ${PATH}; do
			case "$dir" in
				/mnt/*|/cygdrive/*|/proc/cygdrive/*)   last="$last:$dir" ;;
				*)                                     first="$first:$dir" ;;
			esac
		done
		IFS="$OIFS"; unset OIFS
		PATH="${first:1}$last"
		;;
esac
