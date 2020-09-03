" Vim syntax file
" Language: Markdown

syntax region	mkdInlineURL	matchgroup=mkdDelimiter start="<\%(\w\+:\|[^"(),:;<>@[\\\]]\+@[[:alnum:]\-.]\{-}>\)\@=" end=">" keepend oneline

" vim: wrap ts=8 sw=4 sts=0 sta
