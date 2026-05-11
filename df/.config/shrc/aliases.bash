# Necessary for case statement in cs()
shopt -s extglob

# One-line mathematical calculation
calc () { bc <<< "$*"; }

# cd and ls
cs() {
	# Declare local variables
	local path
	local -a cdargs
	local -a lsargs
	local home_esc
	local wdstr
	
	# Parse command line parameters
	# Args before path assumed to be for cd
	# Loop until path is found
	while [ -z "$path" ]; do
		# If no directory specified, default to $HOME
		if [ $# -eq 0 ]; then
			path="$HOME"
			break
		fi
		case "$1" in
			-+([LPe@]) ) cdargs+=("$1")      ;;
			-*         ) lsargs+=("$1")      ;;
			*          ) path="$1"           ;;
		esac
		shift
	done
	# Args after path assumed to be for ls
	lsargs+=("$@")
	
	# Change directory
	cd "${cdargs[@]}" "$path" || return 1
	# Print new working directory
	home_esc=$(sed -e 's/[]\/$*.^[]/\\&/g' <<< "$HOME")
	wdstr="$(pwd | sed "s/^$home_esc\b/~/"):"
	# Use color if available
	[ $COLORS -ge 8 ] && wdstr="$(tput bold)$wdstr$(tput sgr0)"
	printf '%s\n' "$wdstr"
	# List new directory contents
	ls "${lsargs[@]}"
}
