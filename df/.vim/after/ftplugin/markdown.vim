let s:undo_ftplugin = "setl tw< cc< ts< et< fo< isk<"

setlocal textwidth      =78
setlocal colorcolumn    =80

setlocal tabstop        =4
setlocal expandtab

setlocal formatoptions +=t
setlocal iskeyword      =@,48-57,'

if has("syntax")
	setlocal spell
endif

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '|'.s:undo_ftplugin
else
	let b:undo_ftplugin = s:undo_ftplugin
endif
