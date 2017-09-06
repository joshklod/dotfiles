if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

setlocal expandtab

let b:undo_ftplugin = "setl et<"

if has("smartindent")
	setlocal smartindent
	let b:undo_ftplugin .= " si<"
endif
