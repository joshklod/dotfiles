let s:cpo_save = &cpo
set cpo&vim

let s:undo_ftplugin =
		\ "setl tw< ww<" .
		\ "|sil nunmap <buffer> ,c" .
		\ "|sil nunmap <buffer> ,C"

setl textwidth =98
setl winwidth  =100

nmap <buffer> <silent> ,c @="^i' <C-V><Esc>j"<CR>k^
nmap <buffer> <silent> ,C @="^2xj"<CR>k^

let s:undo_ftplugin =
		\ "let s:cpo_save=&cpo | set cpo&vim" .
		\ "|" . s:undo_ftplugin .
		\ "|let &cpo=s:cpo_save | unlet s:cpo_save"
if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '|'.s:undo_ftplugin
else
	let b:undo_ftplugin = s:undo_ftplugin
endif

let &cpo = s:cpo_save
unlet s:cpo_save
