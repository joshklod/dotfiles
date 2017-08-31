" Source text ftplugin
source <sfile>:h/text.vim

setlocal shiftwidth  =4
setlocal softtabstop =4
setlocal expandtab

let s:undo_ftplugin = "setl sw< sts< et<"

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '|'.s:undo_ftplugin
else
	let b:undo_ftplugin = s:undo_ftplugin
endif
