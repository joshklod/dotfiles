let s:cpo_save = &cpo
set cpo&vim

setl textwidth =98
setl winwidth  =100

nmap <buffer> <silent> ,c @="^i' <C-V><Esc>j"<CR>k^
nmap <buffer> <silent> ,C @="^2xj"<CR>k^

" Footer
function! s:undo_ftplugin()
	let l:cpo_save = &cpo
	set cpo&vim

	setlocal tw< ww<
	silent nunmap <buffer> ,c
	silent nunmap <buffer> ,C

	let &cpo = l:cpo_save
	unlet l:cpo_save
endfunction

function! s:SID()
	return matchstr(expand("<sfile>"), '<SNR>\d\+_')
endfunction

if exists("b:undo_ftplugin")
	let b:undo_ftplugin .= "|"
else
	let b:undo_ftplugin = ""
endif
let b:undo_ftplugin .= "call ".s:SID()."undo_ftplugin()"

let &cpo = s:cpo_save
unlet s:cpo_save
