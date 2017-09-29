" Vim syntax file
" Language: ARMbasic

if exists("b:current_syntax")
    finish
endif

syntax clear
syntax case ignore
syntax spell notoplevel
syntax sync minlines=50

" Allows me to specify 'contains=TOP+extra'
syntax	cluster	armbasicTop		contains=TOP

" Strings
" All printable ASCII chars except '"'
syntax	region	armbasicString		excludenl start=/"/ end=/"/ end=/$/ contains=armbasicLineCont,@Spell
syntax	match	armbasicCharacter	/"\([\d32-\d126]\&[^"]\)"/

" Operators
syntax	keyword	armbasicMath		ABS MOD
syntax	match	armbasicMath		"[*/+-]\|<<\|>>"
syntax	match	armbasicBoolOp		/\<\(AND\|OR\|XOR\|NOT\)\>/
syntax	keyword	armbasicOperator	ADDRESSOF
syntax	match	armbasicOperator	/[&+,()]/
syntax	match	armbasicAssignment	/=/
syntax	match	armbasicAssignment	/\([*/+-]\|<<\|>>\|\<\(AND\|OR\|XOR\)\)=/

" Numbers
syntax	cluster	armbasicNumberGroup	contains=armbasicDecimal,armbasicHex,armbasicBinary,armbasicFloat
syntax	match	armbasicDecimal		/\(\<\|\(\W\&\S\&[^).]\|\<\(AND\|OR\|XOR\|NOT\|MOD\|RETURN\|CASE\)\>\)\@<=\s*\zs-\)\d\+\>/
syntax	match	armbasicHex		/\(\$\|&H\)\x\+\>/
syntax	match	armbasicBinary		/%[01]\+\>/
syntax	match	armbasicFloat		/\(\<\|\(\W\&\S\&[^).]\|\<\(AND\|OR\|XOR\|NOT\|MOD\|RETURN\|CASE\)\>\)\@<=\s*\zs-\)\d\+\.\(\d\+\>\)\?/

" Goto Labels
syntax	match	armbasicGotoLabel	/^\s*\zs\h\w*:/ nextgroup=armbasicLabelError
syntax	match	armbasicMain		/^\s*\zsMAIN:/ nextgroup=armbasicLabelError
syntax	region	armbasicLabelError	excludenl start=/./ end=/$/ contained contains=armbasicComment,armbasicLineCont

" Subs and Functions
syntax	keyword	armbasicSub		SUB FUNCTION nextgroup=armbasicSubName skipwhite
syntax	match	armbasicSub		/\<END \=\(SUB\|FUNCTION\)\>/
syntax	match	armbasicSubName		/\<\h\w*\>:\=/ contained

" Statements
syntax	keyword	armbasicStatement	GOSUB CALL EXIT GOTO RETURN __ASM__ CONST DIM
syntax	match	armbasicStatement	/\<END\>\( \(SUB\|FUNCTION\)\)\@!/

" __MAP__
syntax	keyword	armbasicStatement	__MAP__ nextgroup=armbasicMapArgLine
syntax	region	armbasicMapArgLine	excludenl start=/./ end=/$/ contained contains=armbasicMapArgs,armbasicComment,armbasicLineCont
syntax	keyword	armbasicMapArgs		CODE CONST DATA STRING contained nextgroup=@armbasicNumberGroup skipwhite

" Conditionals and loops
syntax	keyword	armbasicConditional	IF ELSEIF nextgroup=armbasicBoolLine
syntax	keyword	armbasicConditional	THEN ELSE
syntax	match	armbasicConditional	/\<SELECT\( CASE\)\?\>/
syntax	match	armbasicConditional	/\<END \?\(IF\|SELECT\)\>/
syntax	keyword	armbasicRepeat		DO FOR LOOP NEXT TO DOWNTO STEP
syntax	keyword	armbasicRepeat		WHILE UNTIL nextgroup=armbasicBoolLine

" Boolean Regions
syntax	region	armbasicBoolLine	excludenl start=/./ end=/\ze\<THEN\>/ end=/$/ contained contains=@armbasicBoolGroup,armbasicComment,armbasicLineCont
syntax	cluster	armbasicBoolGroup	contains=armbasicString,armbasicChar,armbasicMath,armbasicBoolOp,@armbasicNumberGroup,armbasicComparison,armbasicBoolParens,armbasicBoolError
syntax	match	armbasicComparison	/[<>=]\|<=\|<>\|>=/ contained
syntax	region	armbasicBoolParens	excludenl matchgroup=armbasicParen start=/(/ end=/)/ end=/$/ contained contains=@armbasicBoolGroup,armbasicComment,armbasicLineCont
syntax	match	armbasicBoolError	/=\{2,}/ contained

" Other Keywords
syntax	match	armbasicCaseLabel	/\<CASE\( ELSE\)\?\>/
syntax	keyword	armbasicKeyword		AS nextgroup=armbasicType skipwhite

" PreProc
syntax case match
syntax	match	armbasicLineCont	/\\$/ extend

syntax	cluster	armbasicPreProcGroup	contains=armbasicDefine,armbasicPreCondit,armbasicIncLine,armbasicPreIfLine,armbasicPreDiag
syntax	match	armbasicPreProcStart	/^\s*\zs#/ nextgroup=@armbasicPreProcGroup skipwhite

syntax	keyword	armbasicDefine		define undef contained
syntax	keyword	armbasicPreCondit	else endif contained

syntax	region	armbasicIncLine		excludenl matchgroup=armbasicInclude start=/\<include\>/ end=/$/ contained contains=armbasicIncluded,armbasicComment,armbasicLineCont
syntax	region	armbasicIncluded	excludenl start=/"/ end=/"/ end=/$/ contained contains=armbasicLineCont
syntax	region	armbasicIncluded	excludenl start=/</ end=/>/ end=/$/ contained contains=armbasicLineCont

syntax	region	armbasicPreIfLine	excludenl matchgroup=armbasicPreCondit start=/\<if\>/ end=/$/ contained contains=@armbasicTop,armbasicDefined nextgroup=armbasicPreConditBlock skipempty
syntax	region	armbasicPreIfLine	excludenl matchgroup=armbasicPreCondit start=/\<\(ifdef\|ifndef\)\>/ end=/$/ contained contains=@armbasicTop nextgroup=armbasicPreConditBlock skipempty
syntax	region	armbasicPreIfLine	excludenl matchgroup=armbasicPreCondit start=/\<elif\>/ end=/$/ contained contains=@armbasicTop,armbasicDefined

syntax	region	armbasicPreDiag		excludenl matchgroup=armbasicPreProc start=/\<\(warning\|error\)\>/ end=/$/ contained contains=armbasicComment,armbasicLineCont,@Spell

syntax	region	armbasicIf0		matchgroup=armbasicPreCondit start="^\s*\zs#\s*if\s\+0\+\s*\ze\($\|//\|/\*\)" end=/^\s*#\s*endif\>/ end=/^\s*\ze#\s*\(elif\|else\)\>/ contains=armbasicIf0Skip nextgroup=armbasicIf0Else
syntax	region	armbasicIf0		matchgroup=armbasicPreCondit start="^\s*\zs#\s*elif\s\+0\+\s*\ze\($\|//\|/\*\)" end=/^\ze\s*#\s*\(elif\|else\|endif\)\>/ contains=armbasicIf0Skip

syntax	region	armbasicIf0Skip		start=/^\s*#\s*\(if\|ifdef\|ifndef\)\>/ end=/^\s*#\s*endif\>/ transparent contained contains=armbasicIf0Skip
syntax	match	armbasicIf0Else		/\ze#\s*\(elif\|else\)\>/ contained nextgroup=armbasicPreConditBlock

syntax	region	armbasicPreConditBlock	start=/.\@=/ matchgroup=armbasicPreCondit end=/^\s*\zs#\s*endif\>/ contained contains=@armbasicTop

syntax	keyword	armbasicDefined		defined contained
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
syntax	keyword	armbasicTodo		TODO FIXME contained

" Comments
syntax	region	armbasicComment		excludenl start=/'/ start="//" end=/$/ contains=armbasicTodo,armbasicLineCont,@Spell
syntax	region	armbasicComment		start="/\*" end="\*/" keepend contains=armbasicTodo,armbasicLineCont,@Spell

" TODO Add default to all commands after testing
" Comments
" Constants
highlight link armbasicDecimal		armbasicNumber
highlight link armbasicHex		armbasicNumber
highlight link armbasicBinary		armbasicNumber
" Identifiers
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
highlight link armbasicBoolError	armbasicError
highlight link armbasicAssignment	armbasicOperator
" PreProc
highlight link armbasicLineCont		armbasicPreProc
highlight link armbasicPreProcStart	armbasicPreProc
highlight link armbasicIncLine		armbasicError
highlight link armbasicIncluded		armbasicString
highlight link armbasicDefined		armbasicPreProc
highlight link armbasicPreDiag		armbasicString
highlight link armbasicIf0		armbasicComment
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
