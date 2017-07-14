" Vim syntax file
" Language: Markdown

syn region markdownAutomaticLink matchgroup=markdownUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_.+-]\+@\)\@=" end=">" keepend oneline
