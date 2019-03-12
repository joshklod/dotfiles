if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.bas		setfiletype armbasic
augroup END

" vim: ts=8 sw=4
