" Vim syntax file
" Language: ARMbasic

if exists("b:current_syntax")
    finish
endif

syntax clear
syntax case ignore

" Allows me to specify 'contains=TOP+extra'
syntax	cluster	armbasicTop		contains=TOP

" Strings
" All printable ASCII chars except '"'
syntax	match	armbasicString		/"\([\d32-\d126]\&[^"]\)*"/
syntax	match	armbasicCharacter	/"\([\d32-\d126]\&[^"]\)"/

" Operators
syntax	keyword	armbasicMath		ABS MOD
syntax	match	armbasicMath		"[*/+-]\|<<\|>>"
syntax	match	armbasicBoolOp		/\<\(AND\|OR\|XOR\|NOT\)\>/
syntax	region	armbasicParenRegion	matchgroup=armbasicParen start=/(/ end=/)/ oneline contains=TOP
syntax	keyword	armbasicOperator	ADDRESSOF
syntax	match	armbasicOperator	/[&+,]/
syntax	match	armbasicAssignment	/=/
syntax	match	armbasicAssignment	/\([*/+-]\|<<\|>>\|\<\(AND\|OR\|XOR\)\)=/

" Numbers
syntax	cluster	armbasicNumberGroup	contains=armbasicDecimal,armbasicHex,armbasicBinary,armbasicFloat
syntax	match	armbasicDecimal		/\(\<\|-\)\d\+\>/
syntax	match	armbasicHex		/\(\$\|&H\)\x\+\>/
syntax	match	armbasicBinary		/%[01]\+\>/
syntax	match	armbasicFloat		/\(\<\|-\)\d\+\.\(\d\+\>\)\?/

" Goto Labels
syntax	match	armbasicGotoLabel	/^\s*\zs\h\w*:/ nextgroup=armbasicLabelError
syntax	match	armbasicMain		/^\s*\zsMAIN:/ nextgroup=armbasicLabelError
syntax	match	armbasicLabelError	/.\+/ contained contains=armbasicComment

" Variables
"syntax	match	armbasicVariable	/\<\h\w*\ze\s\+\([*/+-]\|<<\|>>\|\<\(AND\|OR\|XOR\)\)\==/ nextgroup=armbasicAssignment

" Subs and Functions
syntax	keyword	armbasicSub		SUB FUNCTION nextgroup=armbasicSubName skipwhite
syntax	match	armbasicSub		/\<END \=\(SUB\|FUNCTION\)\>/
syntax	match	armbasicSubName		/\<\h\w*\>:\=/ contained

" Statements
syntax	keyword	armbasicStatement	GOSUB CALL EXIT GOTO RETURN __ASM__ CONST DIM
syntax	match	armbasicStatement	/\<END\>\( \(SUB\|FUNCTION\)\)\@!/

" __MAP__
syntax	keyword	armbasicStatement	__MAP__ nextgroup=armbasicMapArgLine
syntax	match	armbasicMapArgLine	/.\+/ contained contains=armbasicMapArgs,armbasicComment
syntax	keyword	armbasicMapArgs		CODE CONST DATA STRING contained nextgroup=@armbasicNumberGroup skipwhite

" Conditionals and loops
syntax	keyword	armbasicConditional	IF ELSEIF nextgroup=armbasicBoolLine
syntax	keyword	armbasicConditional	THEN ELSE
syntax	match	armbasicConditional	/\<SELECT\( CASE\)\?\>/
syntax	match	armbasicConditional	/\<END \?\(IF\|SELECT\)\>/
syntax	keyword	armbasicRepeat		DO FOR LOOP NEXT TO DOWNTO STEP
syntax	keyword	armbasicRepeat		WHILE UNTIL nextgroup=armbasicBoolLine

" Boolean Regions
syntax	match	armbasicBoolLine	/[^']\{-}\ze\%(\<THEN\>\|'\|$\)/ contained contains=@armbasicBoolGroup
syntax	cluster	armbasicBoolGroup	contains=armbasicString,armbasicChar,armbasicMath,armbasicBoolOp,@armbasicNumberGroup,armbasicComparison,armbasicBoolParens
syntax	match	armbasicComparison	/[<>=]\|<=\|<>\|>=/ contained
syntax	region	armbasicBoolParens	matchgroup=armbasicParen start=/(/ end=/)/ contained oneline contains=@armbasicBoolGroup

" Other Keywords
syntax	match	armbasicCaseLabel	/\<CASE\( ELSE\)\?\>/
syntax	keyword	armbasicKeyword		AS nextgroup=armbasicType skipwhite

" PreProc
syntax case match
syntax	match	armbasicInclude		/^\s*\zs#\s*include\>/ nextgroup=armbasicIncluded skipwhite
syntax	match	armbasicIncluded	/"[^"]*"\|<[^>]*>/ contained

syntax	match	armbasicDefine		/^\s*\zs#\s*\(define\|undef\)\>/

syntax	match	armbasicPreCondit	/^\s*\zs#\s*\(if\|elif\)\>/ nextgroup=armbasicPreIfLine skipwhite
syntax	match	armbasicPreIfLine	/.\+/ contained contains=@armbasicTop,armbasicDefined
syntax	keyword	armbasicDefined		defined contained

syntax	match	armbasicPreCondit	/^\s*\zs#\s*\(else\|endif\)\>/
syntax	match	armbasicPreCondit	/^\s*\zs#\s*\(ifdef\|ifndef\)\>/

syntax	match	armbasicPreError	/^\s*\zs#\s*\(warning\|error\)\>/ nextgroup=armbasicPreErrorLine
syntax	match	armbasicPreErrorLine	/.\+/ contained contains=armbasicComment
syntax case ignore

" Types
syntax	keyword	armbasicType		INTEGER SINGLE BYTE STRING contained
syntax	keyword	armbasicParamType	BYREF BYVAL PARAMARRAY

" Special
syntax	keyword	armbasicDebug		DEBUGIN PRINT STOP RUN

" Memory Read/Write Debug Commands
syntax	match	armbasicDebug		/@\x*\>/
syntax	match	armbasicDebug		/!\x*\>/ nextgroup=armbasicMemWrite skipwhite
syntax	match	armbasicMemWrite	/\<\x\+\>/ contained

" Others
syntax	match	armbasicError		/==/
syntax	keyword	armbasicTodo		TODO FIXME contained

" Comments
syntax	match	armbasicComment		/'.*/ contains=armbasicTodo
syntax	match	armbasicComment		"//.*" contains=armbasicTodo
syntax	region	armbasicComment		start="/\*" end="\*/" contains=armbasicTodo

" TODO Add default to all commands after testing
" Comments
" Constants
highlight link armbasicDecimal		armbasicNumber
highlight link armbasicHex		armbasicNumber
highlight link armbasicBinary		armbasicNumber
" Identifiers
highlight link armbasicVariable		armbasicIdentifier
highlight link armbasicGotoLabel	armbasicFunction
highlight link armbasicMain		armbasicUnderlined
highlight link armbasicLabelError	armbasicError
highlight link armbasicSub		armbasicType
highlight link armbasicSubName		armbasicFunction
" Statements
highlight link armbasicMapArgLine	armbasicNormal
highlight link armbasicMapArgs		armbasicKeyword
" Operators
highlight link armbasicMath		armbasicOperator
highlight link armbasicBoolOp		armbasicOperator
highlight link armbasicComparison	armbasicOperator
highlight link armbasicParen		armbasicOperator
highlight link armbasicAssignment	armbasicOperator
" PreProc
highlight link armbasicIncluded		armbasicString
highlight link armbasicDefined		armbasicPreProc
highlight link armbasicPreError		armbasicPreProc
highlight link armbasicPreErrorLine	armbasicString
" Types
highlight link armbasicParamType	armbasicType
" Special
highlight link armbasicMemWrite		armbasicNumber
" Others

highlight link armbasicNormal		Normal

highlight link armbasicComment		Comment

highlight link armbasicConstant		Constant
highlight link armbasicString		String
highlight link armbasicCharacter	Character
highlight link armbasicNumber		Number
highlight link armbasicBoolean		Boolean
highlight link armbasicFloat		Float

highlight link armbasicIdentifier	Identifier
highlight link armbasicFunction		Function

highlight link armbasicStatement	Statement
highlight link armbasicConditional	Conditional
highlight link armbasicRepeat		Repeat
highlight link armbasicCaseLabel	Label
highlight link armbasicOperator		Operator
highlight link armbasicKeyword		Keyword
highlight link armbasicException	Exception

highlight link armbasicPreProc		PreProc
highlight link armbasicInclude		Include
highlight link armbasicDefine		Define
highlight link armbasicMacro		Macro
highlight link armbasicPreCondit	PreCondit

highlight link armbasicType		Type
highlight link armbasicStorageClass	StorageClass
highlight link armbasicStructure	Structure
highlight link armbasicTypedef		Typedef

highlight link armbasicSpecial		Special
highlight link armbasicSpecialChar	SpecialChar
highlight link armbasicTag		Tag
highlight link armbasicDelimiter	Delimiter
highlight link armbasicSpecialComment	SpecialComment
highlight link armbasicDebug		Debug

highlight link armbasicUnderlined	Underlined
highlight link armbasicIgnore		Ignore
highlight link armbasicError		Error
highlight link armbasicTodo		Todo

let b:current_syntax = "armbasic"

" vim: wrap ts=8 sw=4 sts=0 sta
