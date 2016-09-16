" A vim syntax file for SISAL

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "sisal"
let s:cpo_save = &cpo
set cpo&vim

" Numeric literals {{{1
"syntax match sisalBooleanLiteral    /\v(\s+|^)[TF]\{1}(\s+|\n)/
syntax match sisalIntegerLiteral    /\v-?\d+/
syntax match sisalRealLiteral       /\v-?\d+\.\d+([eE][+-]*\d+)?/
syntax match sisalDoubleRealLiteral /\v-?\d+\.\d+([dD][+-]*\d+)?/
"highlight link sisalBooleanLiteral    Constant
highlight link sisalIntegerLiteral    Constant
highlight link sisalRealLiteral       Constant
highlight link sisalDoubleRealLiteral Constant

" Error value {{{1
syntax keyword sisalError error
highlight link sisalError WarningMsg

" Identifiers {{{1
syntax match sisalIdentifier /\v<\h\w*>/ contained nextgroup=sisalFunctionArguments
syntax match sisalSingleAssign /\v\zs<\h\w*>\ze\s*:\=/
"syntax match sisalMultiAssign  /\v\zs<\h[a-zA-Z0-9]*>\ze\s*:\=/
syntax region sisalFunctionArguments start='(' end=')' matchgroup=Delimiter contains=@sisalBaseTypes,sisalComplexTypes,sisalIdentifier,sisalReturns nextgroup=sisalIdentifier contained
highlight link sisalIdentifier   Identifier
highlight link sisalSingleAssign Identifier

" Types {{{1
syntax keyword sisalBoolean      boolean
syntax keyword sisalNull         null
syntax keyword sisalComplexTypes array stream record union
highlight link sisalFloats       Type
highlight link sisalBoolean      Type
highlight link sisalNull         Type
highlight link sisalComplexTypes Structure

" We need to match these types separately since they have equivalent
" functions with the same name
syntax match sisalInteger    /\v\zsinteger\ze\(@!/
syntax match sisalReal       /\v\zsreal\ze\(@!/
syntax match sisalDoubleReal /\v\zsdouble_real\ze\(@!/
syntax match sisalCharacter  /\v\zscharacter\ze\(@!/
highlight link sisalInteger    Type
highlight link sisalReal       Type
highlight link sisalDoubleReal Type
highlight link sisalCharacter  Type

syntax cluster sisalBaseTypes contains=sisalBoolean,sisalNull,sisalInteger,sisalReal,sisalDoubleReal,sisalCharacter

" Keywords {{{1
syntax keyword sisalFunctionKeyword function skipwhite nextgroup=sisalIdentifier
syntax keyword sisalTypeAlias       type skipwhite nextgroup=sisalIdentifier
syntax keyword sisalReturns         returns
highlight link sisalFunctionKeyword Keyword
highlight link sisalTypeAlias       Keyword
highlight link sisalReturns         Keyword

syntax keyword sisalKeyword is let in tagcase otherwise forward define old of
syntax keyword sisalBoolean false true
syntax keyword sisalNil     nil
syntax match sisalEndLet      /\vend let/
syntax match sisalEndFunction /\vend function/
highlight link sisalKeyword     Keyword
highlight link sisalBoolean     Boolean
highlight link sisalNil         Special
highlight link sisalEndLet      Keyword
highlight link sisalEndFunction Keyword

" Conditionals {{{1
syntax keyword sisalConditional if then elseif else
syntax match sisalEndIf         /\vend if/
highlight link sisalConditional Conditional
highlight link sisalEndIf       Conditional

" Loops {{{1
syntax keyword sisalLoops for while initial repeat until when dot cross left right tree
syntax match sisalEndFor   /\vend for/
highlight link sisalLoops  Repeat
highlight link sisalEndFor Repeat

" Characters and strings {{{1
syntax region sisalCharacter start="'" end="'"
highlight link sisalCharacter Character

syntax region sisalString start="\"" end="\""
highlight link sisalString String

" Globals/imports {{{1
syntax keyword sisalGlobal global
highlight link sisalGlobal Include

" Operators {{{1
syntax match sisalOperator /\v\*/
syntax match sisalOperator /\v\//
syntax match sisalOperator /\v\+/
syntax match sisalOperator /\v-/
syntax match sisalOperator /\v\|\|/
syntax match sisalOperator /\v\~/
syntax match sisalOperator /\v\|/
syntax match sisalOperator /\v\&/
syntax match sisalOperator /\v\=/
syntax match sisalOperator /\v\~\=/
syntax match sisalOperator /\v\</
syntax match sisalOperator /\v\>/
syntax match sisalOperator /\v<\=/
syntax match sisalOperator /\v>\=/
syntax match sisalOperator /\v:\=/
highlight link sisalOperator Operator

" Built-in functions {{{1
syntax keyword sisalFunction         sum product exp greatest least catenate floor trunc max min mod abs
syntax keyword sisalArrayFunctions   array_fill array_limh array_liml array_size array_prefixsize array_adjust array_addh array_addl array_remh array_reml array_setl
syntax keyword sisalStreamFunctions  stream_append stream_first stream_rest stream_empty stream_size stream_prefixsize
syntax keyword sisalRecordFunctions  replace
syntax match sisalIntegerFunction    /\v\zsinteger\ze\(.+\)/
syntax match sisalRealFunction       /\v\zsreal\ze\(/
syntax match sisalDoubleRealFunction /\v\zsdouble_real\ze\(.+\)/
syntax match sisalCharacterFunction  /\v\zscharacter\ze\(/
highlight link sisalFunction           Function
highlight link sisalArrayFunctions     Function
highlight link sisalStreamFunctions    Function
highlight link sisalIntegerFunction    Function
highlight link sisalRealFunction       Function
highlight link sisalDoubleRealFunction Function
highlight link sisalCharacterFunction  Function

" Comments {{{1
syntax match sisalComment /\v\%.*$/
highlight link sisalComment Comment

" Compiler pragmas {{{1
syntax match sisalPragma /\v^\%\$.*$/
highlight link sisalPragma PreProc

syntax keyword sisalPragmaKeywords INCLUDE SUBRANGE PACKED MAIN containedin=sisalPragma
highlight link sisalPragmaKeywords Special

let &cpo = s:cpo_save
unlet s:cpo_save
