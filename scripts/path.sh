#!/bin/sh

path_is_abs() {
	printf '%s' "$*" | grep -zq -- '^/'
}

path_tilde() {
	home_esc="$(printenv HOME | sed -e 's/[]\:$*.^[]/\\&/g')"
	printf '%s\n' "$*" | sed 's:^'"$home_esc"'\(/\|$\):~\1:'
}

path_abs() {
	path="$*"
	if ! path_is_abs "$path"; then
		path="$PWD/$path"
	fi
	realpath -sm "$path"
}

path_rel() {
	from="$(path_abs "$1")"
	to="$(path_abs "$2")"
	realpath -sm --relative-to "$from" "$to"
}

path_auto() {
	base="$(path_abs "$1")"
	if [ $# -ge 3 ]; then
		from="$(path_abs "$2")"
		to="$(path_abs "$3")"
	else
		from="$base"
		to="$(path_abs "$2")"
	fi
	realpath -sm --relative-base "$base" --relative-to "$from" "$to"
}

path_normalize() {
	if path_is_abs "$*"; then
		path_abs "$*"
	else
		path_rel . "$*"
	fi
}
