" Function start/end jump commands
map <buffer> [[ ?\c^\(SUB\>\\|\h\w*:\)<CR>
map <buffer> [] ?\c^\(END \=SUB\>\\|\h\w*:\)<CR>
map <buffer> ]] /\c^\(SUB\>\\|\h\w*:\)<CR>
map <buffer> ][ /\c^\(END \=SUB\>\\|\h\w*:\)<CR>
