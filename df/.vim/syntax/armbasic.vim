runtime syntax/vb.vim

syntax keyword armbasicConditional ENDIF ENDSELECT de#rp
syntax keyword armbasicStatement   ENDSUB ENDFUNCTION

syntax match   armbasicPreProc     /^\s*#\w\+/

highlight link armbasicConditional vbConditional
highlight link armbasicStatement   vbStatement
highlight link armbasicPreProc     PreProc
