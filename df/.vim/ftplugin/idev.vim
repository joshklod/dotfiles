if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

setlocal expandtab
setlocal commentstring   =//%s

let b:undo_ftplugin = "setl et< cms<"

if has("smartindent")
	setlocal smartindent
	let b:undo_ftplugin .= " si<"
endif
