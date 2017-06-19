let s:undo_ftplugin = "setl tags<"

" Tags
setl tags +=/usr/lib/python*/**/tags

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '|'.s:undo_ftplugin
else
	let b:undo_ftplugin = s:undo_ftplugin
endif
