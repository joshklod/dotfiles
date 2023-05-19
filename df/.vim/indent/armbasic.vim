" Vim indent file
" Language:     ARMbasic
" Maintainer:   Josh Klodnicki <joshklod@gmail.com>
" Last Change:  2023 May 18

if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal autoindent
setlocal indentexpr =GetArmbasicIndent()
let &l:indentkeys = "o,O,!^F,0=~elseif,0=~else,0#,<:>,"
                \ . "0=~endsub,0=~endfunction,0=~endif,0=~endselect,"
                \ . "0=~end sub,0=~end function,0=~end if,0=~end select"

let b:undo_indent = 'setl ai< inde< indk<'

" Only define the function once
if exists("*GetArmbasicIndent")
	let &cpo = s:cpo_save
	finish
endif

function! GetArmbasicIndent()
	let l:plnum = prevnonblank(v:lnum-1)
	if l:plnum == 0
		" This is first line, use 0 indent
		return 0
	endif

	let l:sw      = shiftwidth()
	let l:pindent = indent(plnum)
	let l:cline   = getline(v:lnum)
	let l:pline   = getline(plnum)

	" Middle or end of C-style comment
	if l:cline =~ '^\s*\*'
		return cindent(v:lnum)
	endif

	" label endsub endfunction endif endselect elseif else
	if l:cline =~ '\c^\s*\h\w*:'
		" Goto Label
		return l:pindent < sw ? 0 : l:pindent - sw
	elseif l:cline =~ '\c^\s*#'
		" Preprocessor line
		return 0
	elseif l:cline =~ '\c^\s*end \=\(su\|f\)'
		" End of sub/function
		return l:pindent < sw ? 0 : l:pindent - sw
	elseif l:cline =~ '\c^\s*end \=i'
		" End of if block
		if l:pline =~ '\c^\s*if\>\(.*\<then\>.*\w\)\@!'
			" If immediately following if statement, don't unindent
			return l:pindent
		else
			return l:pindent < sw ? 0 : l:pindent - sw
		endif
	elseif l:cline =~ '\c^\s*end \=se'
		" End of select block
		return l:pindent < sw ? 0 : l:pindent - 2*sw
	elseif l:cline =~ '\c^\s*\(elseif\|else\)'
		" Middle of if block
		return l:pindent < sw ? 0 : l:pindent - sw
	endif

	if l:pline =~ '\c^\s*if\>.*\<then\>\(\(''\|//\|/\*\)\@!.\)*\w'
		" One-line if statement
		return l:pindent
	endif

	if l:pline =~ '\c^\s*\(sub\|function\)\>'
		" Start of sub/function
		return l:pindent + sw
	elseif l:pline =~ '\c^\s*\(if\|elseif\|else\)\>'
		" Multiline if statement
		return l:pindent + sw
	elseif l:pline =~ '\c^\s*\(select\|case\)\>'
		" Select case statement
		return l:pindent + sw
	elseif l:pline =~ '\c^\s*\(do\|while\)\>'
		" Start of do/while loop, etc.
		return l:pindent + sw
	else
		return l:pindent
	endif
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
