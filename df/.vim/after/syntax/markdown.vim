" Vim syntax file
" Language: Markdown

syn region markdownAutomaticLink matchgroup=markdownUrlDelimiter start="<\%(\w\+:\|[^"(),:;<>@[\\\]]\+@[[:alnum:]\-.]\{-}>\)\@=" end=">" keepend oneline

" vim: wrap ts=8 sw=4 sts=0 sta
