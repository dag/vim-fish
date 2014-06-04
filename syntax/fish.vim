if exists('b:current_syntax')
    finish
endif

syntax case match

syntax keyword fishKeyword begin function end not set_color
syntax keyword fishKeyword alias cd contains_seq delete-or-exit dirh
         \ dirs down-or-search eval fish_config fish_default_key_bindings
         \ fish_indent fish_prompt fish_update_completions funced funcsave
         \ grep help history isatty la ll ls man math mimedb nextd
         \ nextd-or-forward-word N_ open popd prevd prevd-or-backward-word
         \ prompt_pwd psub pushd seq setenv sgrep trap type umask
         \ up-or-search vared

syntax keyword fishConditional if else switch
syntax keyword fishRepeat while for in
syntax keyword fishLabel case

syntax match fishOperator "[&;*?]"

syntax region fishSubst matchgroup=fishOperator start="(" skip="\\$" end=")" contains=TOP
syntax region fishBrace matchgroup=fishOperator start="{" skip="\\$" end="}" contains=TOP
syntax match fishRedirect "\d\=\(>>\?\|<\|^^\?\)\(&\(-\|\d\)\)\="
syntax match fishRedirect "\(\d>\)\=|"

syntax match fishComment "#.*$" contains=fishTodo
syntax keyword fishTodo contained TODO FIXME

syntax match fishSpecial "\\[abefnrtv$\\]" "these must be escaped in and out of quoted strings
syntax match fishEscape "\\[{}[\]()&;| *?~%#<>^\"']" "these are not escaped in strings
syntax match fishNumEscape "\\\(\d\d\d\|[xX]\x\x\|u\x\x\x\x\(\x\x\x\x\)\?\|c\a\)"
syntax cluster fishEscapeSeqs contains=fishSpecial,fishEscape,fishNumEscape

syntax match fishSet "set\s\+" nextgroup=fishSetOpt,fishIdentifier
syntax match fishSetOpt contained "-[eglLnquUx]\s\+" nextgroup=fishIdentifier
syntax match fishSetOpt contained "--\(local\|global\|universal\|names\|\(un\)\=export\|erase\|query\|long\)\s\+" nextgroup=fishIdentifier
syntax match fishIdentifier contained "\w\+"

syntax match fishVarDeref "\$\+\w\+" " NB: $$foo is allowed: multiple deref
syntax region fishVarDeref start="\$\+\w\+\[" skip=/\\$/ end="]" contains=fishSubst,fishVarDeref
syntax region fishString matchgroup=fishOperator start=/'/ skip=/\\'/ end=/'/ contains=fishSpecial
syntax region fishString matchgroup=fishOperator start=/"/ skip=/\\"/ end=/"/ contains=fishVarDeref,fishSpecial,fishStringError
syntax match fishNumber "[-+]\=\d\+"
syntax cluster fishValues contains=fishVarDeref,fishString,fishNumber

syntax region fishTest matchgroup=fishOperator start="\[" skip="\\$" end="\]" contains=@fishTestContents
syntax match fishTestOp contained "-[a-gGhkLnoOprsStuwxz]"
syntax match fishTestOp contained "-\(eq\|ge\|gt\|le\|lt\|ne\|ef\|nt\|ot\)"
syntax match fishTestOp contained "\s\zs\(!=\|!\|=\)\ze\s"
syntax match fishTestError contained "=="
syntax region fishTestMatched contained matchgroup=fishTestOp start="(" skip="\\$" end=")" contains=@fishTestContents
syntax cluster fishTestContents contains=fishTestOp,fishTestMatched,fishTestError,
         \ @fishEscapeSeqs,@fishValues

" Some sequences used in Bourne-like shells, but not fish
syntax match fishVarDerefError "@" " array dereference op.
syntax keyword fishError do done then fi export local " keywords
syntax match fishError "\(&&\|||\|!!\|=\|\[\[\|]]\)" "syntax
syntax match fishStringError "\$[-#@*$?!]" " special variables
syntax region fishStringError start="\${" end="}" " safe dereferencing
syntax region fishStringError start="\$(" end=")" " var substitution

highlight default link fishKeyword Keyword
highlight default link fishConditional Conditional
highlight default link fishRepeat Repeat
highlight default link fishLabel Label

highlight default link fishComment Comment
highlight default link fishTodo Todo

highlight default link fishEscape Special
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
highlight default link fishTestError Error

highlight default link fishError Error
highlight default link fishStringError fishError

let b:current_syntax = 'fish'
