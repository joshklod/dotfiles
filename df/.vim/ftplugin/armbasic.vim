if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let s:undo_ftplugin =
		\ "setl comments<" .
		\ "|sil unmap <buffer> ]]" .
		\ "|sil unmap <buffer> [[" .
		\ "|sil unmap <buffer> ][" .
		\ "|sil unmap <buffer> []"

" Comments
setlocal comments=:'

" Function start/end jump commands
map <buffer> ]] /\c^\(SUB\>\<Bar>\h\w*:\)<CR>
map <buffer> [[ ?\c^\(SUB\>\<Bar>\h\w*:\)<CR>
map <buffer> ][ /\c^\(END \=SUB\>\<Bar>\h\w*:\)<CR>
map <buffer> [] ?\c^\(END \=SUB\>\<Bar>\h\w*:\)<CR>

let &cpo = s:cpo_save
unlet s:cpo_save

let s:undo_ftplugin =
		\ "let s:cpo_save=&cpo | set cpo&vim" .
		\ "|" . s:undo_ftplugin .
		\ "|let &cpo=s:cpo_save | unlet s:cpo_save"
if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '|'.s:undo_ftplugin
else
	let b:undo_ftplugin = s:undo_ftplugin
endif
