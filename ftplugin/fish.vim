setlocal commentstring=#%s
setlocal iskeyword=@,48-57,-,_,.,/
setlocal formatprg=fish_indent
setlocal omnifunc=fish#Complete

" Use the 'man' wrapper function in fish to include fish's man pages.
" Have to use a script for this; 'fish -c man' would make the the man page an
" argument to fish instead of man.
execute 'setlocal keywordprg=fish\ '.expand('<sfile>:p:h:h').'/bin/man.fish'

let b:match_words = escape('<%(begin|function|if|switch|while|for)>:<end>','<>%|)')

let b:endwise_addition = 'end'
let b:endwise_words = 'begin,function,if,switch,while,for'
let b:endwise_syngroups = 'fishKeyword,fishConditional,fishRepeat'
