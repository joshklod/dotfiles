if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal iskeyword      +=$
setlocal comments        =sr:/*,m:*,ex:*/,://,:'
setlocal commentstring   =//%s

" Function start/end jump commands
nnoremap <silent><buffer> ]] :     call <SID>FuncJump(0, 0, 0)<CR>
nnoremap <silent><buffer> [[ :     call <SID>FuncJump(0, 1, 0)<CR>
nnoremap <silent><buffer> ][ :     call <SID>FuncJump(1, 0, 0)<CR>
nnoremap <silent><buffer> [] :     call <SID>FuncJump(1, 1, 0)<CR>
xnoremap <silent><buffer> ]] :<C-U>call <SID>FuncJump(0, 0, 1)<CR>
xnoremap <silent><buffer> [[ :<C-U>call <SID>FuncJump(0, 1, 1)<CR>
xnoremap <silent><buffer> ][ :<C-U>call <SID>FuncJump(1, 0, 1)<CR>
xnoremap <silent><buffer> [] :<C-U>call <SID>FuncJump(1, 1, 1)<CR>

function! s:FuncJump(side, backward, visual)
	" When invoked from visual mode, reselect the visual area
	if a:visual
		normal! gv
	endif

	" side == 0: Beginning of function
	" side == 1: End of function
	if a:side == 0
		let l:search_str = '\c^\s*\(SUB\|FUNCTION\)\>'
	else
		let l:search_str = '\c^\s*END \=\(SUB\|FUNCTION\)\>'
	endif

	let l:flags = 'Ws'
	if a:backward
		let l:flags .= 'b'
	endif

	call search(l:search_str, l:flags)
endfunction

" Footer
function! s:undo_ftplugin()
	let l:cpo_save = &cpo
	set cpo&vim

	setlocal iskeyword< comments< commentstring<
	silent unmap <buffer> ]]
	silent unmap <buffer> [[
	silent unmap <buffer> ][
	silent unmap <buffer> []

	let &cpo = l:cpo_save
	unlet l:cpo_save
endfunction

function! s:SID()
	return matchstr(expand("<sfile>"), '<SNR>\d\+_\zeSID$')
endfunction

let b:undo_ftplugin = "call ".s:SID()."undo_ftplugin()"

let &cpo = s:cpo_save
unlet s:cpo_save
