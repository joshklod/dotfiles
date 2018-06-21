" Vim syntax file
" Language: CSS

" These are commented out in distributed syntax file
syntax keyword	cssDeprecatedTagName	acronym applet basefont big center dir font frame frameset noframes strike tt containedin=cssMediaBlock

" Add missing unit labels, and fix matching '%'
syntax match	cssValueLength		contained "[-+]\=\d\+\(\.\d*\)\=\(%\|\(ch\|vh\|vw\|vmin\|vmax\)\>\)" contains=cssUnitDecorators

" calc()
syntax region	cssFunction		contained matchgroup=cssFunctionName start="\<calc\s*(" end=")" oneline contains=cssValueInteger,cssValueNumber,cssValueLength,cssFunction

" var()
syntax region	cssFunction		contained matchgroup=cssFunctionName start="\<var\s*(" end=")" oneline keepend contains=cssCustomProp,cssVarDefault
syntax region	cssVarDefault		contained matchgroup=cssFunctionComma start=/,/ matchgroup=cssFunctionName end=/)/ contains=@cssAttrGroup

" --custom-properties
syntax match	cssCustomProp		contained /--\a[[:alnum:]_-]*/

" TODO Figure out how to get this to work for any font name without sabotaging
"      every other property
syntax keyword	cssFontAttr		contained Consolas Inconsolata

" This might be a typo?
syntax keyword	cssPseudoClassId	contained enabled
" Highlight inside not() function
syntax region	cssPseudoClassFn	contained matchgroup=cssFunctionName start="\<not(" end=")" contains=@cssSelectorGroup

" Flexbox
syntax match	cssFlexibleBoxProp	contained /\<flex\(-\(basis\|direction\|flow\|grow\|shrink\|wrap\)\)\=/
syntax match	cssFlexibleBoxProp	contained /\<\(justify-content\|align-\(items\|content\|self\)\|order\)\>/
syntax keyword	cssFlexibleBoxAttr	contained wrap nowrap center
syntax match	cssFlexibleBoxAttr	contained /\<\(inline-\)\=flex\>/
syntax match	cssFlexibleBoxAttr	contained /\<\(row\|column\|wrap\)\(-reverse\)\=\>/
syntax match	cssFlexibleBoxAttr	contained /\<\(flex-\(start\|end\)\|space-\(between\|around\)\)\>/
" This is necessary because 'space' is already a keyword
syntax match	cssFlexibleBoxAttr	contained /\(\<space\)\@<=-\(between\|around\)\>/

" Define clusters after everything else so wildcards match all groups
syntax cluster	cssSelectorGroup	contains=cssTagName,cssAttributeSelector,cssClassName,cssIdentifier,cssDeprecatedTagName
syntax cluster	cssDefinitionGroup	contains=cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssVendor,cssDefinition,cssHacks,cssNoise
syntax cluster	cssAttrGroup		contains=css.*Attr,cssColor,cssImportant,cssValue.*,cssFunction,cssString.*,cssURL,cssComment,cssUnicodeEscape,cssVendor,cssError,cssAttrComma,cssNoise

" These need to be re-defined to include new group members
syntax region	cssDefinition		transparent matchgroup=cssBraces start='{' end='}' contains=@cssDefinitionGroup fold
syntax region	cssAttrRegion		start=/:/ end=/\ze\(;\|)\|}\)/ contained contains=@cssAttrGroup
" Hack for transition
" 'transition' has Props after ':'.
syntax region	cssAttrRegion		start=/transition\s*:/ end=/\ze\(;\|)\|}\)/ contained contains=css.*Prop,@cssAttrGroup

highlight link cssFunction		Normal

highlight link cssDeprecatedTagName	PreProc
highlight link cssCustomProp		cssProp

" vim: wrap ts=8 sw=4 sts=0 sta
