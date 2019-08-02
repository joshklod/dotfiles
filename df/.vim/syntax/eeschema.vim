" Vim syntax file
" Language: EESchema

if exists("b:current_syntax")
    finish
endif

syntax clear
syntax case ignore
syntax sync minlines=50

" Allows me to specify 'contains=TOP+extra'
syntax	cluster	eeschemaTop		contains=TOP

" Constants
syntax	region	eeschemaString		excludenl start=/"/ end=/"/ end=/$/ contains=@Spell
syntax	match	eeschemaNumber		/\(^\|\s\)\@<=-\?\<\d\+\>/

" Generic Statements
syntax	match	eeschemaSOL		/^/ nextgroup=eeschemaStatement
syntax	match	eeschemaStatement	/^\h\w*\>/ contained
syntax	region	eeschemaBlock		matchgroup=eeschemaBlockLabel start=/^\$\(end\w*\)\@!\z(\h\w*\)\>/ end=/^\$end\z1\>/ keepend contains=TOP

syntax	match	eeschemaBlockLabel	/^\$EndSCHEMATI\=C/ " I think this is a typo...

" Others
syntax	keyword	eeschemaPreProc		encoding contained
syntax	match	eeschemaPreProc		/End\s\+Library/ contained

" Comments
syntax	region	eeschemaComment		excludenl start=/^#/ end=/$/ contains=eeschemaPreProc,@Spell

" TODO Add default to all commands after testing

highlight link eeschemaBlockLabel	eeschemaType

highlight link eeschemaNormal		Normal

highlight link eeschemaComment		Comment

highlight link eeschemaConstant		Constant
highlight link eeschemaString		String
highlight link eeschemaCharacter	Character
highlight link eeschemaNumber		Number
highlight link eeschemaBoolean		Boolean
highlight link eeschemaFloat		Float

highlight link eeschemaIdentifier	Identifier
highlight link eeschemaFunction		Function

highlight link eeschemaStatement	Statement
highlight link eeschemaConditional	Conditional
highlight link eeschemaRepeat		Repeat
highlight link eeschemaCaseLabel	Label
highlight link eeschemaOperator		Operator
highlight link eeschemaKeyword		Keyword
highlight link eeschemaException	Exception

highlight link eeschemaPreProc		PreProc
highlight link eeschemaInclude		Include
highlight link eeschemaDefine		Define
highlight link eeschemaMacro		Macro
highlight link eeschemaPreCondit	PreCondit

highlight link eeschemaType		Type
highlight link eeschemaStorageClass	StorageClass
highlight link eeschemaStructure	Structure
highlight link eeschemaTypedef		Typedef

highlight link eeschemaSpecial		Special
highlight link eeschemaSpecialChar	SpecialChar
highlight link eeschemaTag		Tag
highlight link eeschemaDelimiter	Delimiter
highlight link eeschemaSpecialComment	SpecialComment
highlight link eeschemaDebug		Debug

highlight link eeschemaUnderlined	Underlined
highlight link eeschemaIgnore		Ignore
highlight link eeschemaError		Error
highlight link eeschemaTodo		Todo

let b:current_syntax = "eeschema"

" vim: wrap ts=8 sw=4 sts=0 sta
