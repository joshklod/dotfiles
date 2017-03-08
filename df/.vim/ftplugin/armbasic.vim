" Comments
setlocal comments=:'

" Function start/end jump commands
map <buffer> ]] /\c^\(SUB\>\<Bar>\h\w*:\)<CR>
map <buffer> [[ ?\c^\(SUB\>\<Bar>\h\w*:\)<CR>
map <buffer> ][ /\c^\(END \=SUB\>\<Bar>\h\w*:\)<CR>
map <buffer> [] ?\c^\(END \=SUB\>\<Bar>\h\w*:\)<CR>
