if exists('b:did_ftplugin')
    finish
end
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

setlocal comments=:#
setlocal commentstring=#%s
setlocal define=\\v^\\s*function>
setlocal foldexpr=fish#Fold()
setlocal formatoptions+=ron1
setlocal formatoptions-=t
setlocal include=\\v^\\s*\\.>
setlocal iskeyword=@,48-57,-,_,.,/
setlocal suffixesadd^=.fish

" Use the 'j' format option when available.
if v:version ># 703 || v:version ==# 703 && has('patch541')
    setlocal formatoptions+=j
endif

if executable('fish_indent')
    setlocal formatexpr=fish#Format()
endif

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
execute 'setlocal keywordprg=fish\ '.fnameescape(expand('<sfile>:p:h:h').'/bin/man.fish')

let b:match_words = escape(
            \'<%(begin|function|%(else\s\+)\@<!if|switch|while|for)>:<else\s\+if>:<else>:<end>'
            \, '<>%|)')

let b:endwise_addition = 'end'
let b:endwise_words = 'begin,function,if,switch,while,for'
let b:endwise_syngroups = 'fishKeyword,fishConditional,fishRepeat'

let b:undo_ftplugin = "
            \ setlocal comments< commentstring< define< foldexpr< formatoptions<
            \|setlocal include< iskeyword< suffixesadd<
            \|setlocal formatexpr< omnifunc< path< keywordprg<
            \|unlet! b:match_words b:endwise_addition b:endwise_words b:endwise_syngroups
            \"

let &cpo = s:save_cpo
unlet s:save_cpo
