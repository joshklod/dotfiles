#!/bin/sh
#
# word-textconv.sh - Wrapper for docx2txt for use as a git diff filter

command -v docx2txt.pl >/dev/null 2>&1 && docx2txt.pl "$1" -
