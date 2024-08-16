" Vim syntax file
" Language: C

" Match anything ending in "_t" or "_T"
syntax match	cType		"\<\h\w*_[Tt]\>"
" Match anything ending in "_[efkpsux]t"
syntax match	cType		"\<\h\w*_[efkpsux]t\>"
" Match anything ending in "_Type" or "_TypeDef"
syntax match	cType		"\<\h\w*\%(_t\|T\)ype\%([Dd]ef\)\=\>"
" Match anything starting with "t_"
syntax match	cType		"\<t_\w\+\>"

" vim: wrap ts=8 sw=4 sts=0 sta

