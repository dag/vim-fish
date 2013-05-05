syntax clear

syntax case match

syntax keyword fishKeyword begin function end
syntax keyword fishConditional if else switch
syntax keyword fishRepeat while for
syntax keyword fishLabel case

syntax match fishComment /#.*/
syntax match fishIdentifier /\$[[:alnum:]_]\+/
syntax region fishString start=/'/ skip=/\\'/ end=/'/
syntax region fishString start=/"/ skip=/\\"/ end=/"/ contains=fishIdentifier
syntax match fishCharacter /\v\\[abefnrtv *?~%#(){}\[\]<>&;"']|\\[xX][0-9a-f]{1,2}|\\o[0-7]{1,2}|\\u[0-9a-f]{1,4}|\\U[0-9a-f]{1,8}|\\c[a-z]/
syntax match fishStatement /\v%(^|\(|;)\s*\zs\k+/

highlight! link fishKeyword Keyword
highlight! link fishConditional Conditional
highlight! link fishRepeat Repeat
highlight! link fishLabel Label
highlight! link fishComment Comment
highlight! link fishIdentifier Identifier
highlight! link fishString String
highlight! link fishCharacter Character
highlight! link fishStatement Statement

let b:current_syntax = 'fish'
