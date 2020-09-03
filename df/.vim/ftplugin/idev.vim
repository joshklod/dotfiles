if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal expandtab
setlocal commentstring   =//%s

if has("smartindent")
	setlocal smartindent
endif

" Footer
function! s:undo_ftplugin()
	setlocal expandtab<
	setlocal commentstring<
	if has('smartindent')
		setlocal smartindent<
	endif
endfunction

function! s:SID()
	return matchstr(expand("<sfile>"), '<SNR>\d\+_')
endfunction

let b:undo_ftplugin = "call ".s:SID()."undo_ftplugin()"

let &cpo = s:cpo_save
unlet s:cpo_save
