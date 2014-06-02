if exists('b:current_syntax')
    finish
endif

syntax case match

syntax keyword fishKeyword begin function end set not set_color
syntax keyword fishInternalFunction alias cd contains_seq delete-or-exit dirh
         \ dirs down-or-search eval fish_config fish_default_key_bindings
         \ fish_indent fish_prompt fish_update_completions funced funcsave
         \ grep help history isatty la ll ls man math mimedb nextd
         \ nextd-or-forward-word N_ open popd prevd prevd-or-backward-word
         \ prompt_pwd psub pushd seq setenv sgrep trap type umask
         \ up-or-search vared

syntax keyword fishConditional if else switch
syntax keyword fishRepeat while for in
syntax keyword fishLabel case
syntax keyword fishTodo contained TODO FIXME

syntax match fishOperator "[{}[\]()&;]"
syntax match fishRedirect "\d\=\(>>\?\|<\|^^\?\)\(&\(-\|\d\)\)\="
syntax match fishRedirect "\(\d>\)\=|"

syntax match fishComment "#.*$" contains=fishTodo

syntax match fishSpecial "\\[abefnrtv$\\]" "these must be escaped in and out of quoted strings
syntax match fishEscape "\\[{}[\]()&;| *?~%#<>^\"']" "these are not escaped in strings
syntax match fishNumEscape "\\\(\d\d\d\|[xX]\x\x\|u\x\x\x\x\(\x\x\x\x\)\?\|c\a\)"

syntax match fishIdentifier "\$\w\+"
syntax region fishString start=/'/ skip=/\\'/ end=/'/ contains=fishSpecial
syntax region fishString start=/"/ skip=/\\"/ end=/"/ contains=fishIdentifier,fishSpecial
syntax match fishNumber "[-+]\?\d\+"

highlight default link fishKeyword Keyword
highlight default link fishInternalFunction fishKeyword
highlight default link fishConditional Conditional
highlight default link fishRepeat Repeat
highlight default link fishLabel Label

highlight default link fishComment Comment
highlight default link fishTodo Todo

highlight default link fishEscape Special
highlight default link fishSpecial fishEscape
highlight default link fishNumEscape fishEscape

highlight default link fishIdentifier Identifier
highlight default link fishString String
highlight default link fishNumber Number

highlight default link fishOperator Operator
highlight default link fishRedirect fishOperator

let b:current_syntax = 'fish'
