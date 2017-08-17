" Help files use a .txt extension and read ftplugin files for text filetype
" erroneously. Disable that here.
if &buftype == "help"
	finish
endif

let s:undo_ftplugin = 'setl tw< cc< fo< isk<'

setlocal textwidth      =78
setlocal colorcolumn    =80

setlocal formatoptions +=t
setlocal iskeyword      =@,48-57,'

if has("syntax")
	setlocal spell
	let s:undo_ftplugin .= ' spell<'
endif

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '|'.s:undo_ftplugin
else
	let b:undo_ftplugin = s:undo_ftplugin
endif
