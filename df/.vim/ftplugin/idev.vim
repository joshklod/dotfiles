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

function! IdevTagFunc(pattern, flags, info)
	let l:cfile   = a:info.buf_ffname
	let l:cdir    = fnamemodify(l:cfile, ':h')

	let l:magic        = &magic ? '\m' : '\M'
	let l:search_pat   =
				\ '\v\c<(FUNC|LIB|VAR|STYLE|PAGE|STRUCT)\s*'
				\.'\(\s*('.l:magic.a:pattern.'\v)'

	let l:taglist = []
	for l:file in glob(l:cdir.'/*.mnu', 0, 1)
				\ ->filter({ i,f -> f != l:cfile })
				\ ->insert(l:cfile)
				\ ->filter({ i,f -> filereadable(f) })
				\ ->map({ i,f -> fnamemodify(f, ':.') })
		let l:lines   = readfile(l:file)
		let l:idx     = 0
		while l:idx < len(l:lines)
			let l:match = matchlist(l:lines[l:idx], l:search_pat)
			if !empty(l:match)
				eval l:taglist->add(#{
						\ name:     l:match[2],
						\ filename: l:file,
						\ cmd:      string(l:idx+1),
						\ type:     tolower(l:match[1])
					\ })
			endif
			let l:idx += 1
		endwhile
	endfor

	return l:taglist
endfunc
setlocal tagfunc =IdevTagFunc

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
