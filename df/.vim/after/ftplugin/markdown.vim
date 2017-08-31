" Source text ftplugin
source <sfile>:h/text.vim

setlocal tabstop   =4
setlocal expandtab

let s:undo_ftplugin = "setl ts< et<"

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '|'.s:undo_ftplugin
else
	let b:undo_ftplugin = s:undo_ftplugin
endif
