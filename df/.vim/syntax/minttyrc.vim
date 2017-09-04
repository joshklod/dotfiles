" Vim syntax file
" Language: minttyrc

" quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syntax clear
syntax case    match

syntax keyword minttyrcOption     Term Language Locale Charset
syntax match   minttyrcComment    /#.*/
syntax match   minttyrcIdentifier /\<\w\+\>/

highlight link minttyrcOption     minttyrcIdentifier
highlight link minttyrcComment    Comment
highlight link minttyrcIdentifier Identifier

" If you do not want these operators lit, uncommment them and the "highlight link" below
syntax match   matlabArithmeticOperator    "[-+]"
syntax match   matlabArithmeticOperator    "\.\=[*/\\^]"
syntax match   matlabRelationalOperator    "[=~]="
syntax match   matlabRelationalOperator    "[<>]=\="
syntax match   matlabLogicalOperator        "[&|~]"

syntax match   matlabLineContinuation    "\.\{3}"

"syntax match   matlabIdentifier        "\<\a\w*\>"

" String
" MT_ADDON - added 'skip' in order to deal with 'tic' escaping sequence 
syntax region  matlabString            start=+'+ end=+'+    oneline skip=+''+

" If you don't like tabs
syntax match   matlabTab            "\t"

" Standard numbers
syntax match   matlabNumber        "\<\d\+[ij]\=\>"
" floating point number, with dot, optional exponent
syntax match   matlabFloat        "\<\d\+\(\.\d*\)\=\([edED][-+]\=\d\+\)\=[ij]\=\>"
" floating point number, starting with a dot, optional exponent
syntax match   matlabFloat        "\.\d\+\([edED][-+]\=\d\+\)\=[ij]\=\>"

" Transpose character and delimiters: Either use just [...] or (...) aswell
syntax match   matlabDelimiter        "[][]"
"syntax match   matlabDelimiter        "[][()]"
syntax match   matlabTransposeOperator    "[])a-zA-Z0-9.]'"lc=1

syntax match   matlabSemicolon        ";"

syntax match   matlabComment            "%.*$"    contains=matlabTodo,matlabTab
" MT_ADDON - correctly highlights words after '...' as comments
syntax match   matlabComment            "\.\.\..*$"    contains=matlabTodo,matlabTab
syntax region  matlabMultilineComment    start=+%{+ end=+%}+ contains=matlabTodo,matlabTab

syntax keyword matlabOperator        break zeros default margin round ones rand
syntax keyword matlabOperator        ceil floor size clear zeros eye mean std cov

syntax keyword matlabFunction        error eval function

syntax keyword matlabImplicit        abs acos atan asin cos cosh exp log prod sum
syntax keyword matlabImplicit        log10 max min sign sin sinh sqrt tan reshape

syntax match   matlabError    "-\=\<\d\+\.\d\+\.[^*/\\^]"
syntax match   matlabError    "-\=\<\d\+\.\d\+[eEdD][-+]\=\d\+\.\([^*/\\^]\)"

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

highlight default link matlabTransposeOperator  matlabOperator
highlight default link matlabOperator           Operator
highlight default link matlabLineContinuation   Special
highlight default link matlabLabel              Label
highlight default link matlabConditional        Conditional
highlight default link matlabExceptions         Conditional
highlight default link matlabRepeat             Repeat
highlight default link matlabTodo               Todo
highlight default link matlabString             String
highlight default link matlabDelimiter          Identifier
highlight default link matlabTransposeOther     Identifier
highlight default link matlabNumber             Number
highlight default link matlabFloat              Float
highlight default link matlabFunction           Function
highlight default link matlabError              Error
highlight default link matlabImplicit           matlabStatement
highlight default link matlabStatement          Statement
highlight default link matlabOO                 Statement
highlight default link matlabSemicolon          SpecialChar
highlight default link matlabComment            Comment
highlight default link matlabMultilineComment   Comment
highlight default link matlabScope              Type

highlight default link matlabArithmeticOperator matlabOperator
highlight default link matlabRelationalOperator matlabOperator
highlight default link matlabLogicalOperator    matlabOperator

"optional highlighting
"highlight default link matlabIdentifier        Identifier
"highlight default link matlabTab            Error


let b:current_syntax = "minttyrc"

" vim: wrap ts=8 sw=4 sts=0 sta
