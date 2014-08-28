if exists('b:current_syntax')
    finish
endif

syntax case match

syntax keyword fishBuiltins contains_seq delete-or-exit down-or-search
         \ fish_default_key_bindings grep la ll ls man nextd-or-forward-word
         \ N_ prevd-or-backward-word prompt_pwd seq setenv sgrep up-or-search
syntax keyword fishKeyword alias begin bg bind block break breakpoint builtin
         \ cd command commandline complete continue count dirh dirs echo emit
         \ end eval exec exit fg fish fish_config fish_indent fish_pager
         \ fish_prompt fish_right_prompt fish_update_completions fishd funced
         \ funcsave function functions help history isatty jobs math mimedb
         \ nextd not open popd prevd psub pushd pwd random read return set
         \ set_color status trap type ulimit umask vared
syntax match fishKeyword "\<contains\>"
syntax match fishKeyword "command\ze\s\(tes[^t]\|te[^s]\|t[^e]\|[^t]\)"
syntax keyword fishKeywordError do done then fi export local

syntax keyword fishConditional if else switch or and
syntax keyword fishRepeat while for in
syntax keyword fishLabel case

syntax match fishOperator "[&;*?]"

syntax region fishSubst matchgroup=fishOperator start="(" skip="\\$" end=")" contains=TOP
syntax region fishBrace matchgroup=fishOperator start="{" skip="\\$" end="}" contains=TOP
syntax match fishRedirect "\d\=\(>>\?\|<\|\^\^\?\)\(&\(-\|\d\)\)\="
syntax match fishRedirect "\(\d>\)\=|"

syntax match fishComment "#.*$" contains=fishTodo
syntax keyword fishTodo contained TODO FIXME

syntax match fishSpecial "\\[abefnrtv$\\]" "these must be escaped in and out of quoted strings
syntax match fishEOLEscape "\\$"
syntax match fishEscape "\\[{}[\]()&;| *?~%#<>^\"']" "these are not escaped in strings
syntax match fishNumEscape "\\\(\d\d\d\|[xX]\x\x\|u\x\x\x\x\(\x\x\x\x\)\?\|c\a\)"
syntax cluster fishEscapeSeqs contains=fishSpecial,fishEscape,fishNumEscape

syntax match fishSet "\<set\s\+" nextgroup=fishSetOpt,fishIdentifier
syntax match fishSetOpt contained "-[eglLnquUx]\+\s\+" nextgroup=fishSetOpt,fishIdentifier
syntax match fishSetOpt contained "--\(local\|global\|universal\|names\|\(un\)\=export\|erase\|query\|long\)\s\+" nextgroup=fishSetOpt,fishIdentifier
syntax match fishIdentifier contained "\w\+"

syntax match fishVarDerefError "@" " array dereference op.
syntax match fishVarDerefError "\$[-#@*$?!]" " special variables
syntax region fishVarDerefError start="\${" end="}" " safe dereferencing
syntax region fishVarDerefError start="\$(" end=")" " var substitution
syntax match fishVarDeref "\$\+\w\+" " NB: $$foo is allowed: multiple deref
syntax region fishVarDeref start="\$\+\w\+\[" skip=/\\$/ end="]" contains=fishSubst,fishVarDeref
syntax region fishString matchgroup=fishOperator start=/'/ skip=/\\'/ end=/'/ contains=fishSpecial
syntax region fishString matchgroup=fishOperator start=/"/ skip=/\\"/ end=/"/ contains=fishVarDeref,fishSpecial,fishStringError
syntax match fishNumber "\<[-+]\=\d\+\>"
syntax cluster fishValues contains=fishVarDeref,fishString,fishNumber

syntax region fishTest matchgroup=fishOperator start="\[" skip="\\$" end="\]" contains=@fishTestContents
syntax region fishTest matchgroup=fishKeyword start="test" end="\([^\\]\zs$\|\ze\s*#\)" contains=@fishTestContents
syntax match fishTestOp contained "\<-[a-hnoprstuwxzLS]\>"
syntax match fishTestOp contained "\<-\(eq\|ne\|ge\|gt\|le\|lt\)\>"
syntax match fishTestOp contained "\<\(!=\|!\|=\)\>"
syntax cluster fishTestContents contains=fishTestOp,fishSubst,@fishError,@fishEscapeSeqs,@fishValues,fishEOLEscape
syntax match fishOpError "\<\(-ef\|-ot\|-nt\|==\|&&\|||\|!!\|=\|\[\[\|]]\)\>" "syntax

" Some sequences used in Bourne-like shells, but not fish
syntax cluster fishError contains=fishKeywordError,fishOpError,fishVarDerefError,fishStringError

highlight default link fishKeyword Keyword
highlight default link fishBuiltins fishKeyword
highlight default link fishConditional Conditional
highlight default link fishRepeat Repeat
highlight default link fishLabel Label

highlight default link fishComment Comment
highlight default link fishTodo Todo

highlight default link fishEscape Special
highlight default link fishEOLEscape fishEscape
highlight default link fishSpecial fishEscape
highlight default link fishNumEscape fishEscape

highlight default link fishIdentifier Identifier
highlight default link fishSet Keyword
highlight default link fishSetOpt Operator
highlight default link fishVarDeref Identifier
highlight default link fishString String
highlight default link fishNumber Number

highlight default link fishOperator Operator
highlight default link fishRedirect fishOperator

highlight default link fishTestOp Operator

highlight default link fishError Error
highlight default link fishKeywordError fishError
highlight default link fishOpError fishError
highlight default link fishVarDerefError fishError
highlight default link fishStringError fishError

let b:current_syntax = 'fish'
