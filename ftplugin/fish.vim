setlocal comments=:#
setlocal commentstring=#%s
setlocal formatoptions+=ron1j
setlocal formatoptions-=t
setlocal formatprg=fish_indent
setlocal include=\\v^\\s*\\.>
setlocal iskeyword=@,48-57,-,_,.,/
setlocal suffixesadd=.fish

if executable('fish')
    setlocal omnifunc=fish#Complete
    for s:path in split(system("fish -c 'echo $fish_function_path'"))
        execute 'setlocal path+='.s:path
    endfor
else
    setlocal omnifunc=syntaxcomplete#Complete
endif

" Use the 'man' wrapper function in fish to include fish's man pages.
" Have to use a script for this; 'fish -c man' would make the the man page an
" argument to fish instead of man.
execute 'setlocal keywordprg=fish\ '.expand('<sfile>:p:h:h').'/bin/man.fish'

let b:match_words = escape('<%(begin|function|if|switch|while|for)>:<end>','<>%|)')

let b:endwise_addition = 'end'
let b:endwise_words = 'begin,function,if,switch,while,for'
let b:endwise_syngroups = 'fishKeyword,fishConditional,fishRepeat'
