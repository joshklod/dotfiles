#!/bin/sh
#
# gen-db.sh - Generate terminfo database

script_dir=$(dirname "$0")

cd "$script_dir"
tic -xo ~/.terminfo src/xterm-truecolor.terminfo
