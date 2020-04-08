if exists('b:current_syntax')
    finish
endif

syntax case match
syntax iskeyword @,48-57,-,_,.,/

" https://en.wikipedia.org/wiki/List_of_Unix_commands
syntax keyword fishUnixCommand admin alias ar asa at awk basename batch bc bg
  \ cc c99 cal cat cd cflow chgrp chmod chown cksum cmp comm command compress
  \ cp crontab csplit ctags cut cxref date dd delta df diff dirname du echo
  \ ed env ex expand expr false fc fg file find fold fort77 fuser gencat get
  \ getconf getopts grep hash head iconv id ipcrm ipcs jobs join kill lex
  \ less link ln locale localedef logger logname lp ls m4 mailx make man mesg
  \ mkdir mkfifo more mv newgrp nice nl nm nohup od paste patch pathchk pax
  \ pr printf prs ps pwd qalter qdel qhold qmove qmsg qrerun qrls qselect
  \ qsig qstat qsub read renice rm rmdel rmdir sact sccs sed sh sleep sort
  \ split strings strip stty tabs tail talk tee test time touch tput tr true
  \ tsort tty type ulimit umask unalias uname uncompress unexpand unget uniq
  \ unlink uucp uudecode uuencode uustat uux val vi wait wc what who
  \ write xargs yacc zcat

syntax cluster fishKeyword contains=fishBlock,fishFunction,fishConditional,
  \ fishRepeat,fishLabel,fishControl,fishOperator,fishBoolean,fishCommand
syntax keyword fishBlock begin end
syntax keyword fishConditional if else switch
syntax keyword fishRepeat while for in
syntax keyword fishLabel case
syntax keyword fishControl return break continue exit
syntax keyword fishOperator and or not
syntax keyword fishBoolean true false

" http://fishshell.com/docs/current/commands.html
syntax keyword fishCommand abbr alias argparse bg bind block breakpoint
  \ builtin cd cdh command commandline complete contains[] count dirh dirs
  \ disown echo emit eval exec fg fish fish_breakpoint_prompt fish_config
  \ fish_git_prompt fish_hg_prompt fish_indent fish_key_reader
  \ fish_mode_prompt fish_opt fish_prompt fish_right_prompt
  \ fish_svn_prompt fish_update_completions fish_vcs_prompt funced funcsave
  \ functions help history isatty jobs math nextd open popd prevd printf
  \ prompt_pwd psub pushd pwd random read realpath set set_color source
  \ status suspend test time trap type ulimit umask vared wait
syntax match fishCommand /\v<string(\s+(collect|escape|join|join0|length|lower
  \ |match|repeat|replace|split|split0|sub|trim|unescape|upper))=>/

syntax keyword fishFunction function nextgroup=fishFunctionName skipwhite
syntax match fishFunctionName '[^[:space:]/()-][^[:space:]/()]*' contained
  \ contains=fishString,fishDeref

syntax match fishOperator '[\[\]=*~%&|<>!+-]'
syntax match fishOperator '\.\.'

syntax match fishComment /#.*/
syntax match fishSpecial /[\();]/
syntax match fishSpecial /\\\$/
syntax match fishOption /\v<[+-][[:alnum:]-_]+>/
syntax match fishNumber /\v<[+-]=(\d+\.)=\d+>/

syntax match fishDeref /\$\+[[:alnum:]_]\+/ nextgroup=fishDerefExtension
syntax region fishDerefExtension matchgroup=fishOperator start=/\[/ end=/\]/ contains=fishDeref,fishNumber,fishOperator contained

syntax match fishSingleQuoteEscape /\\[\\']/ contained
syntax match fishDoubleQuoteEscape /\\[\\"$\n]/ contained
syntax cluster fishStringEscape contains=fishSingleQuoteEscape,fishDoubleQuoteEscape

syntax region fishString start=/'/ skip=/\v(\\{2})|(\\)'/ end=/'/ contains=fishSingleQuoteEscape
syntax region fishString start=/"/ skip=/\v(\\{2})|(\\)"/ end=/"/ contains=fishDoubleQuoteEscape,fishDeref,fishDerefExtension
syntax match fishCharacter /\v\\[0abefnrtv *?~%#(){}\[\]<>&;"']|\\[xX][0-9a-f]{1,2}|\\o[0-7]{1,2}|\\u[0-9a-f]{1,4}|\\U[0-9a-f]{1,8}|\\c[a-z]/
syntax match fishCharacter /\v\\e[a-zA-Z0-9]/

highlight default link fishKeyword Keyword
highlight default link fishBlock fishKeyword
highlight default link fishFunction fishKeyword
highlight default link fishConditional Conditional
highlight default link fishRepeat Repeat
highlight default link fishLabel Label
highlight default link fishCommand Keyword
highlight default link fishUnixCommand Keyword
highlight default link fishFunctionName Function
highlight default link fishComment Comment
highlight default link fishOperator Operator
highlight default link fishSpecial Special
highlight default link fishDeref PreProc
highlight default link fishString String
highlight default link fishSingleQuoteEscape Special
highlight default link fishDoubleQuoteEscape Special
highlight default link fishNumber Number
highlight default link fishCharacter Character
highlight default link fishOption Constant
highlight default link fishBoolean Boolean
highlight default link fishControl Exception

let b:current_syntax = 'fish'
