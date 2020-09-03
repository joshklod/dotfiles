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

" Function start/end jump commands
nnoremap <silent><buffer> ]] :     call <SID>FuncJump(0, 0)<CR>
xnoremap <silent><buffer> ]] :<C-U>call <SID>FuncJump(0, 1)<CR>
nnoremap <silent><buffer> [[ :     call <SID>FuncJump(1, 0)<CR>
xnoremap <silent><buffer> [[ :<C-U>call <SID>FuncJump(1, 1)<CR>

" Match '{' at the end of a line instead of column 0
function! s:FuncJump(backward, visual)
	" When invoked from visual mode, reselect the visual area
	if a:visual
		normal! gv
	endif

	let l:search_str   = '^\S\@=\%(/\*.*\*/\|\%(/[/*]\)\@!.\)*\_s*\zs{'
	                 \ . '\s*\%(/[/*].*\)\=$'
	let l:flags        = 'Ws'

	if a:backward
		let l:flags .= 'b'
	endif

	call search(l:search_str, l:flags)
endfunction

" Footer
function! s:undo_ftplugin()
	setlocal expandtab<
	setlocal commentstring<
	if has('smartindent')
		setlocal smartindent<
	endif

	silent nunmap <buffer> ]]
	silent xunmap <buffer> ]]
	silent nunmap <buffer> [[
	silent xunmap <buffer> [[
endfunction

function! s:SID()
	return matchstr(expand("<sfile>"), '<SNR>\d\+_')
endfunction

let b:undo_ftplugin = "call ".s:SID()."undo_ftplugin()"

let &cpo = s:cpo_save
unlet s:cpo_save
