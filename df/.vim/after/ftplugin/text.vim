let s:undo_ftplugin = 'setl tw< cc< fo< isk<'

setlocal textwidth      =78
setlocal colorcolumn    =80

setlocal formatoptions +=t
setlocal iskeyword      =@,48-57,'

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '|'.s:undo_ftplugin
else
	let b:undo_ftplugin = s:undo_ftplugin
endif
