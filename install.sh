#!/bin/sh

set -o errexit

script_dir="$(dirname "$0")"

. "$script_dir/scripts/path.sh"

prints() {
	printf '%s\n' "$*"
}

printm() {
	type="$1"; shift

	case "$type" in
		out  ) prints "$*" ;;
		info ) prints >&2 "Note: $*" ;;
		warn ) prints >&2 "Warning: $*" ;;
		err  ) prints >&2 "Error: $*" ;;
	esac
}

do_cmd() {
	printm out "$@"
	"$@"
}

back_up() {
	orig="$1"
	backup="$orig.bak"

	if [ -e "$backup" ]; then
		printm warn "Failed to back up '$orig' - '$backup' already exists"
		return 1
	fi

	do_cmd mv "$orig" "$backup" || {
		printm warn "Failed to back up '$orig'"
		return 1
	}

	return 0
}

link() {
	target="$1"
	link_dir="$2"
	link_name="${3-$(basename "$target")}"

	target="$(path_auto "$dest" "$link_dir" "$target")"
	file="$(path_normalize "$link_dir/$link_name")"

	if [ -e "$file" ]; then
		if [ -h "$file" ]; then
			if [ "$(readlink "$file")" = "$target" ]; then
				printm info "'$file' is already linked"
				return 0
			fi
		fi

		printm info "'$file' already exists.  Backing up..."
		back_up "$file" || return 1
	fi

	do_cmd ln -s "$target" "$file" || return 1

	return 0
}

dest="${1-$HOME}"

if ! [ -e "$dest" ]; then
	printm err "Destination '$dest' does not exist"
	exit 1
elif ! [ -d "$dest" ]; then
	printm err "Destination '$dest' is not a directory"
	exit 1
elif ! [ -w "$dest" ]; then
	printm err "Destination '$dest' is not writable"
	exit 1
fi

config="$(path_normalize "$dest/.config")"

if ! [ -d "$(realpath -m "$config")" ]; then
	if [ -e "$config" ]; then
		printm err "'$config' is not a directory"
		exit 2
	fi

	do_cmd mkdir "$config"
fi

dest_link="$(path_normalize "$dest/.df")"
config_link="$(path_normalize "$config/.df")"

link "$script_dir/df" "$dest" ".df"
link "$dest_link"   "$config" ".df"

while IFS= read -r file; do
	[ -z "$file" ] && continue
	link "$file" "$dest" || true
done <<-EOF
	$(find -L "$dest_link" -mindepth 1 -maxdepth 1 -not -name '.config')
EOF

while IFS= read -r file; do
	[ -z "$file" ] && continue
	link "$file" "$config" || true
done <<-EOF
	$(find -L "$config_link/.config" -mindepth 1 -maxdepth 1)
EOF

while IFS= read -r dir; do
	[ -z "$dir" ] && continue
	if [ -f "$dir/install" ]; then
		do_cmd "$dir/install" || true
	fi
done <<-EOF
	$(find -L "$script_dir/scripts" -mindepth 1 -maxdepth 1 -type d)
EOF
