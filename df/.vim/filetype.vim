if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.bas		setfiletype armbasic
    au! BufRead,BufNewFile *.i			setfiletype c
    au! BufRead,BufNewFile *.sch,*.lib
	\ if (getline(1) =~# 'EESchema') | setfiletype eeschema | endif
augroup END

" vim: ts=8 sw=4
