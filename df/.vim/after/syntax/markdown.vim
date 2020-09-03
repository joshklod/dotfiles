" Vim syntax file
" Language: Markdown

syntax region	mkdInlineURL	matchgroup=mkdDelimiter start="<\%(\w\+:\|[^"(),:;<>@[\\\]]\+@[[:alnum:]\-.]\{-}>\)\@=" end=">" keepend oneline
syntax match	mkdEscape	/\\./ transparent contains=NONE

syntax cluster	mkdNonListItem	add=mkdEscape

" vim: wrap ts=8 sw=4 sts=0 sta
