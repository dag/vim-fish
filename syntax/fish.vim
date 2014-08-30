if exists('b:current_syntax')
    finish
endif

syntax case match

syntax cluster fishCommand contains=NONE
syntax match fishLineStart "\%(\\\@1<!\%(\\\\\)*\\\n\)\@<!\_^" nextgroup=@fishCommand skipwhite

syntax keyword fishKeyword contained
            \ contains_seq delete-or-exit down-or-search
            \ fish_default_key_bindings grep la ll ls man nextd-or-forward-word
            \ N_ prevd-or-backward-word prompt_pwd seq setenv sgrep up-or-search
syntax keyword fishKeyword contained
            \ alias begin bg bind block break breakpoint builtin cd
            \ commandline complete \contains continue count dirh dirs echo emit
            \ end eval exec exit fg fish fish_config fish_indent fish_pager
            \ fish_prompt fish_right_prompt fish_update_completions fishd funced
            \ funcsave function functions help history isatty jobs math mimedb
            \ nextd not open popd prevd psub pushd pwd random read return
            \ set_color source status trap type ulimit umask vared
syntax keyword fishKeyword command contained nextgroup=@fishCommand skipwhite
syn match fishKeyword "\.\ze\%(\s\|$\)" contained
syn cluster fishCommand add=fishKeyword
syntax keyword fishKeywordError do done then fi export local contained
syn cluster fishCommand add=fishKeywordError

syntax keyword fishConditional if else switch or and not contained nextgroup=@fishCommand skipwhite
syn cluster fishCommand add=fishConditional
syntax keyword fishRepeat while contained nextgroup=@fishCommand skipwhite
syntax keyword fishRepeat for contained nextgroup=fishRepeatForVar skipwhite
syn cluster fishCommand add=fishRepeat
syntax region fishRepeatForVar start="\S" end="\ze\%(\s\|;\|$\)" contained contains=@fishValues,@fishEscapeSeqs nextgroup=fishRepeatIn skipwhite
syntax keyword fishRepeatIn in contained
syntax keyword fishLabel case contained
syn cluster fishCommand add=fishLabel

syntax match fishOperator "[*?]"
syntax match fishOperator "[;&]" nextgroup=@fishCommand skipwhite

syntax region fishSubst matchgroup=fishOperator start="(" end=")" excludenl end="$" contains=TOP
syntax match fishSubstStart "\ze." contained containedin=fishSubst nextgroup=@fishCommand skipwhite
syntax region fishBrace matchgroup=fishOperator start="{" end="}" excludenl end="$" contains=TOP
syntax match fishRedirect "\d\=\(>>\?\|<\|\^\^\?\)\(&\(-\|\d\)\)\="
syntax match fishPipe "\(\d>\)\=|" nextgroup=@fishCommand skipwhite skipnl

syntax match fishComment excludenl "#.*$" contains=fishTodo
syntax match fishComment "#.*\\\@1<!\%(\\\\\)*\\$" contains=fishTodo,fishCommentEscape nextgroup=@fishCommand skipwhite
syntax keyword fishTodo contained TODO FIXME
syntax match fishCommentEscape "\\\n" contained

syntax match fishSpecial "\\[abefnrtv$\\]" "these must be escaped in and out of quoted strings
syntax match fishEscape ,\\[{}[\]()&;| *?~%#<>^"'\n], "these are not escaped in strings
syntax match fishNumEscape "\\\(\d\d\d\|[xX]\x\x\|u\x\x\x\x\(\x\x\x\x\)\?\|c\a\)"
syntax cluster fishEscapeSeqs contains=fishSpecial,fishEscape,fishNumEscape

syntax match fishSet "\<set\>\ze\%(\s\|;\|$\)" contained nextgroup=fishSetOpt,fishSetIdentifier skipwhite
syn cluster fishCommand add=fishSet
syntax region fishSetIdentifier start="\S" end="\ze\%(\s\|;\|$\)" contained contains=@fishValues,@fishEscapeSeqs
syntax match fishSetOpt contained "-[eglLnquUx]\+\ze\%(\s\|;\|$\)" nextgroup=fishSetOpt,fishSetIdentifier skipwhite
syntax match fishSetOpt contained "--\(local\|global\|universal\|names\|\(un\)\=export\|erase\|query\|long\)\ze\%(\s\|;\|$\)" nextgroup=fishSetOpt,fishSetIdentifier skipwhite
syntax match fishSetOpt contained "--\ze\%(\s\|;\|$\)" nextgroup=fishSetIdentifier skipwhite

syntax match fishVarDerefError "\$[-#@*$?!]" " special variables
syntax region fishVarDerefError start="\${" end="}" " safe dereferencing
syntax region fishVarDerefError start="\$(" end=")" " var substitution
syntax match fishVarDeref "\$\+\w\+" " NB: $$foo is allowed: multiple deref
syntax region fishVarDeref start="\$\+\w\+\[" end="]" excludenl end="$" contains=fishSubst,fishVarDeref,@fishEscapeSeqs
syntax region fishString matchgroup=fishOperator start=/'/ end=/'/ contains=fishSpecial,fishSingleQuoteEscape
syntax match fishSingleQuoteEscape "\\'" contained
syntax region fishString matchgroup=fishOperator start=/"/ end=/"/ contains=fishVarDeref,fishSpecial,fishDoubleQuoteEscape
syntax match fishDoubleQuoteEscape '\\"' contained
syntax match fishNumber "\<[-+]\=\d\+\>"
syntax cluster fishValues contains=fishVarDeref,fishString,fishNumber,fishVarDerefError

syntax region fishTest matchgroup=fishOperator start="\[" end="\]" end="\ze[;#]" excludenl end="$" contained contains=@fishTestContents
syntax region fishTest matchgroup=fishKeyword start="\<test\>" end="\ze[;#]" excludenl end="$" contained contains=@fishTestContents
syn cluster fishCommand add=fishTest
syntax match fishTestOp contained "\s\@1<=-[a-hnoprstuwxzLS]\>"
syntax match fishTestOp contained "\s\@1<=-\%(eq\|ne\|ge\|gt\|le\|lt\)\>"
syntax match fishTestOp contained excludenl "\s\@1<=\%(!=\|!\|=\)\%($\|\s\@=\)"
syntax cluster fishTestContents contains=fishTestOp,fishSubst,fishOpError,fishTestOpError,@fishEscapeSeqs,@fishValues
syntax match fishTestOpError contained excludenl "\s\@1<=\%(==\|>\|<\)\%($\|\s\@=\)"

" Some sequences used in Bourne-like shells, but not fish
syntax match fishOpError "==\|&&\|||\|!!\|\[\[\|]]" "syntax

highlight default link fishKeyword Keyword
highlight default link fishConditional Conditional
highlight default link fishRepeat Repeat
highlight default link fishRepeatForVar fishSetIdentifier
highlight default link fishRepeatIn Repeat
highlight default link fishLabel Label

highlight default link fishComment Comment
highlight default link fishTodo Todo

highlight default link fishEscape Special
highlight default link fishSpecial fishEscape
highlight default link fishNumEscape fishEscape
highlight default link fishCommentEscape fishEscape

highlight default link fishSet Keyword
highlight default link fishSetOpt Operator
highlight default link fishSetIdentifier Identifier
highlight default link fishVarDeref Identifier
highlight default link fishString String
highlight default link fishSingleQuoteEscape fishEscape
highlight default link fishDoubleQuoteEscape fishEscape
highlight default link fishNumber Number

highlight default link fishOperator Operator
highlight default link fishRedirect fishOperator
highlight default link fishPipe fishOperator

highlight default link fishTestOp Operator

highlight default link fishError Error
highlight default link fishKeywordError fishError
highlight default link fishOpError fishError
highlight default link fishVarDerefError fishError

syn sync minlines=50
syn sync maxlines=500

let b:current_syntax = 'fish'
