" Help files use a .txt extension and read ftplugin files for text filetype
" erroneously. Disable that here.
if &buftype == "help"
	finish
endif

setlocal textwidth      =78

setlocal formatoptions +=t
setlocal iskeyword      =@,48-57,'

let s:undo_ftplugin = 'setl tw< fo< isk<'

if has("syntax")
	setlocal spell
	let s:undo_ftplugin .= ' spell<'
endif

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '|'.s:undo_ftplugin
else
	let b:undo_ftplugin = s:undo_ftplugin
endif
