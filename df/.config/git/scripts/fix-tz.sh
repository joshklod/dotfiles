#!/bin/sh
#
# fix-tz.sh - Change the timezone of all commits in the repository matching
#             certain criteria

from="$1"
to="$2"
after="$3"
before="$4"

if [ $# -gt 4 ]; then
	shift 4
	tips="$@"
fi

# Portable version of `echo`
prints() {
	printf '%s\n' "$*"
}

set_indir() {
	local name=$1
	shift
	eval "$name='$*'"
}
get_indir() {
	eval "prints \"\$$1\""
}

awk_test='1'
[ -n "$from"     ] && awk_test="$awk_test && \$2 == \"$from\""
[ -n "$to"       ] && awk_test="$awk_test && \$2 != \"$to\""
[ -n "$after"    ] && awk_test="$awk_test && \$1 >= \"$after\""
[ -n "$before"   ] && awk_test="$awk_test && \$1 < \"$before\""
# printf 'awk_test: >%s<\n' "$awk_test"

: ${from:='[+-][0-9]\{4\}'}
: ${to:=''}
: ${tips:='--all'}

# printf 'from: %s\nto: %s\nafter: %s\nbefore: %s\ntips: %s\n' \
# 		"$from" "$to" "$after" "$before" "$tips"

env_filter="
if [ \"\$(git log -1 --date=format:'%z' --pretty='%aI %ad' \$GIT_COMMIT |
		awk '$awk_test { print \"yes\" }')\" = yes ]; then
	export GIT_AUTHOR_DATE=\"\$(printenv GIT_AUTHOR_DATE |
			sed 's/$from/$to/')\"
fi
if [ \"\$(git log -1 --date=format:'%z' --pretty='%cI %cd' \$GIT_COMMIT |
		awk '$awk_test { print \"yes\" }')\" = yes ]; then
	export GIT_COMMITTER_DATE=\"\$(printenv GIT_COMMITTER_DATE |
			sed 's/$from/$to/')\"
fi
"

change=$(
	git log --date=format:'%z' --pretty='%aI %ad %H%n%cI %cd %H' $tips |
	awk "$awk_test { print \$3 }" |
	uniq)
printf '%s\n' "Commits to be changed:" $change

for c in $change; do set_indir refs_$c "$(git ls-refs --contains $c)"; done

refs_all=$(for c in $change; do get_indir refs_$c; done | sort -u)

rev_list=$(
	for c in $change; do git rev-list "$c^!" $(get_indir refs_$c); done |
	sort -u)

printf '%s\n' 'Refs to be updated:' $refs_all
# printf '%s\n' 'rev_list:' "$rev_list"

if [ -n "$rev_list" ]; then
	export FILTER_BRANCH_SQUELCH_WARNING=1
	git filter-branch --env-filter "$env_filter" -- \
			--no-walk $refs_all $rev_list
else
	prints "Nothing to do."
fi
