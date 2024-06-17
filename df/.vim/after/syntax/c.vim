" Vim syntax file
" Language: C

" Match anything ending in "_t" or "_[efksux]t"
syntax match	cType		"\<\h\w*_[efksux]\=t\>"
" Match anything ending in "_Type" or "_TypeDef"
syntax match	cType		"\<\h\w*\%(_t\|T\)ype\%([Dd]ef\)\=\>"

" vim: wrap ts=8 sw=4 sts=0 sta

