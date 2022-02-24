if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

function! s:format()
	?^DRAW\>?/^X\>/mark [
	/^ENDDRAW\>/?^X\>?mark ]
	'[,']sort /X\s\+\S\+\s\+/
	'[,']sort r /X\s\+\(\S\+\s\+\)\{8}\zs\d\+/
	'[,']s/\s\+/ /g
	noh
endfunction
nnoremap <buffer><silent> <LocalLeader>f :call <SID>format()<CR>

function! s:columnate()
	?^DRAW\>?/^X\>/mark [
	/^ENDDRAW\>/?^X\>?mark ]
	'[,']sort n /X\s\+\S\+\s\+/
	'[,']sort r /X\s\+\(\S\+\s\+\)\{8}\zs\d\+/
	'[,']!column -t
	noh
endfunction
nnoremap <buffer><silent> <LocalLeader>c :call <SID>columnate()<CR>

" Footer
function! s:undo_ftplugin()
	silent unmap <buffer> <LocalLeader>f
	silent unmap <buffer> <LocalLeader>c
endfunction

function! s:SID()
	return matchstr(expand("<sfile>"), '<SNR>\d\+_\zeSID$')
endfunction

let b:undo_ftplugin = "call ".s:SID()."undo_ftplugin()"

let &cpo = s:cpo_save
unlet s:cpo_save

