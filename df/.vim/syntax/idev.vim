" Vim syntax file
" Language: iDevOS

if exists("b:current_syntax")
	finish
endif

syntax case ignore

syntax	match	idevFunction	/\<\h\w*\ze\s*(/

syntax	match	idevString	/"[^"]*"/ contains=idevHexChar
syntax	match	idevNumber	/-\=\<\d\+\>\|\\\\\x\+/
syntax	match	idevHexChar	/\\\\\x\{2}/ contained

syntax	match	idevOperator	/[()[\]{};=<>?:,]\|\<\(AND\|OR\)\>/

syntax	match	idevComment	"//.*" contains=idevTodo
syntax	region	idevComment	start="/\*" end="\*/" contains=idevTodo
syntax	keyword	idevTodo	TODO


highlight default link idevHexChar		idevSpecial

highlight default link idevNormal		Normal

highlight default link idevComment		Comment

highlight default link idevConstant		Constant
highlight default link idevString		String
highlight default link idevCharacter		Character
highlight default link idevNumber		Number
highlight default link idevBoolean		Boolean
highlight default link idevFloat		Float

highlight default link idevIdentifier		Identifier
highlight default link idevFunction		Function

highlight default link idevStatement		Statement
highlight default link idevConditional		Conditional
highlight default link idevRepeat		Repeat
highlight default link idevLabel		Label
highlight default link idevOperator		Operator
highlight default link idevKeyword		Keyword
highlight default link idevException		Exception

highlight default link idevPreProc		PreProc
highlight default link idevInclude		Include
highlight default link idevDefine		Define
highlight default link idevMacro		Macro
highlight default link idevPreCondit		PreCondit

highlight default link idevType			Type
highlight default link idevStorageClass		StorageClass
highlight default link idevStructure		Structure
highlight default link idevTypedef		Typedef

highlight default link idevSpecial		Special
highlight default link idevSpecialChar		SpecialChar
highlight default link idevTag			Tag
highlight default link idevDelimiter		Delimiter
highlight default link idevSpecialComment	SpecialComment
highlight default link idevDebug		Debug

highlight default link idevUnderlined		Underlined
highlight default link idevIgnore		Ignore
highlight default link idevError		Error
highlight default link idevTodo			Todo

let b:current_syntax = "idev"

" vim: wrap ts=8
