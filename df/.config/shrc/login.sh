# Make non-login POSIX shells work with shrc
export ENV="$HOME/.shrc.sh"

# Make non-interactive non-login Bash shells work with shrc
export BASH_ENV="$HOME/.bashrc"

# Configure locale
export LANG=en_US.UTF-8
export LC_COLLATE=C.UTF-8 # Sort capitals first and don't ignore punctuation

# Prepend portable tree bin directories to $PATH
if [ -d "$HOME/opt/tree" ]; then
	while IFS= read -r tree; do
		[ -z "$tree" ] && continue
		export PATH="$tree/bin:$PATH"
	done <<-EOF
		$(find -L "$HOME/opt/tree" -mindepth 1 -maxdepth 1 \
		       -type d \! -name 'available')
	EOF
fi

# Prepend personal bin directories to $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/bin:$PATH"

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
