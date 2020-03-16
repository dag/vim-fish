if exists('b:current_syntax')
    finish
endif

syntax case match
syntax iskeyword @,48-57,-,_,.,/

syntax cluster fishKeyword contains=fishBlock,fishFunction,fishConditional,
  \ fishRepeat,fishLabel,fishControl,fishOperator,fishBoolean,fishCommand
syntax keyword fishBlock begin end
syntax keyword fishConditional if else switch
syntax keyword fishRepeat while for in
syntax keyword fishLabel case
syntax keyword fishControl return break continue exit
syntax keyword fishOperator and or not
syntax keyword fishBoolean true false

syntax keyword fishFunction function nextgroup=fishFunctionName skipwhite
syntax match fishFunctionName /\k\+/ contained

" http://fishshell.com/docs/current/commands.html
syntax keyword fishCommand abbr alias argparse bg bind block breakpoint
  \ builtin cd cdh command commandline complete count dirh dirs disown echo
  \ emit eval exec fg fish funced funcsave functions help history isatty jobs
  \ math nextd open popd prevd printf prompt_pwd psub pushd pwd random read
  \ realpath set set_color source status suspend test time trap type
  \ ulimit umask vared wait contains[]
syntax match fishCommand /\v<string(\s+(collect|escape|join|join0|length|lower
  \ |match|repeat|replace|split|split0|sub|trim|unescape|upper))=>/

syntax match fishOperator '[\[\]=*%&|<>!+-]'
syntax match fishComment /#.*/
syntax match fishSpecial /[\();]/
syntax match fishSpecial /\zs\$\ze\$/
syntax match fishArgument /\v<[+-]+\k+>/
syntax match fishNumber /\v<[+-]=(\d+\.)=\d+>/

syntax match fishDeref /\$[[:alnum:]_]\+/
syntax region fishString start=/'/ skip=/\v(\\{2})|(\\)'/ end=/'/
syntax region fishString start=/"/ skip=/\v(\\{2})|(\\)"/ end=/"/ contains=fishDeref,fishCharacter
syntax match fishCharacter /\v\\[abefnrtv *?~%#(){}\[\]<>&;"']|\\[xX][0-9a-f]{1,2}|\\o[0-7]{1,2}|\\u[0-9a-f]{1,4}|\\U[0-9a-f]{1,8}|\\c[a-z]|\\e[a-zA-Z0-9]/

highlight default link fishKeyword Keyword
highlight default link fishBlock fishKeyword
highlight default link fishFunction fishKeyword
highlight default link fishConditional Conditional
highlight default link fishRepeat Repeat
highlight default link fishLabel Label
highlight default link fishCommand Keyword
highlight default link fishFunctionName Function
highlight default link fishComment Comment
highlight default link fishOperator Operator
highlight default link fishSpecial Special
highlight default link fishDeref PreProc
highlight default link fishString String
highlight default link fishNumber Number
highlight default link fishCharacter Character
highlight default link fishArgument Constant
highlight default link fishBoolean Boolean
highlight default link fishControl Exception

let b:current_syntax = 'fish'
