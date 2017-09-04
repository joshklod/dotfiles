if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

if has("smartindent")
	setlocal smartindent
	let b:undo_ftplugin = "setl si<"
endif
