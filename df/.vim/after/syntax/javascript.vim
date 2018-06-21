" Vim syntax file
" Language: Javascript

" Corrections

syntax match	javaScriptNumber	/-\=\<\d\+\(\.\d*\)\=\>/

if exists("javaScript_fold")
    syntax clear  javaScriptFunctionFold
    syntax region javaScriptBracesFold	matchgroup=javaScriptBraces start=/{/ end=/}/ transparent fold
    syntax match  javaScriptBraces	/[\[\]]/
    syntax match  javaScriptParens	/[()]/
endif

highlight default link javaScriptValue	Number

" Additions

" New Function Syntax
syntax match	javaScriptFunction		/=>/
" Getter/setter methods
syntax keyword	javaScriptFunction		get set
" Placeholder string substitution
syntax region	javaScriptStringT		start=/`/ skip=/\\\\\|\\`/ end=/`\|$/ contains=javaScriptSpecial,javaScriptPlaceholder,@htmlPreproc
syntax region	javaScriptPlaceholder		matchgroup=javaScriptSpecial start=/\${/ end=/}/ contains=TOP
" Promises
syntax keyword	javaScriptType			Promise
syntax keyword	javaScriptPromiseResolve	resolve reject
syntax match	javaScriptPromiseMethod		/\.\(then\|catch\|finally\)\>/ transparent contains=javaScriptPromiseThen,javaScriptPromiseCatch
syntax keyword	javaScriptPromiseThen		contained then
syntax keyword	javaScriptPromiseCatch		contained catch finally

highlight default link javaScriptNormal		Normal
highlight default link javaScriptString		String

highlight default link javaScriptStringT	javaScriptString
highlight default link javaScriptPlaceholder	javaScriptNormal
highlight default link javaScriptPromiseResolve	javaScriptStatement
highlight default link javaScriptPromiseThen	javaScriptPromiseMethod
highlight default link javaScriptPromiseCatch	javaScriptPromiseMethod

" vim: wrap ts=8 sw=4 sts=0 sta
