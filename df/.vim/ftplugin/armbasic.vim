if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

" Comments
setlocal comments=:'

" Function start/end jump commands
map <buffer> ]] /\c^\(SUB\>\<Bar>\h\w*:\)<CR>
map <buffer> [[ ?\c^\(SUB\>\<Bar>\h\w*:\)<CR>
map <buffer> ][ /\c^\(END \=SUB\>\<Bar>\h\w*:\)<CR>
map <buffer> [] ?\c^\(END \=SUB\>\<Bar>\h\w*:\)<CR>

" Footer
function! s:undo_ftplugin()
	let l:cpo_save = &cpo
	set cpo&vim

	setlocal comments<
	silent unmap <buffer> ]]
	silent unmap <buffer> [[
	silent unmap <buffer> ][
	silent unmap <buffer> []

	let &cpo = l:cpo_save
	unlet l:cpo_save
endfunction

function! s:SID()
	return matchstr(expand("<sfile>"), '<SNR>\d\+_')
endfunction

let b:undo_ftplugin = "call ".s:SID()."undo_ftplugin()"

let &cpo = s:cpo_save
unlet s:cpo_save
