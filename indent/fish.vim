setlocal indentexpr=GetFishIndent()
setlocal indentkeys+==end,=else,=case

if exists('*GetFishIndent')
    finish
endif

function GetFishIndent()
    let l:lnum = prevnonblank(v:lnum - 1)

    if l:lnum ==# 0
        return 0
    endif

    let l:ind = 0

    if getline(l:lnum) =~# '\v^\s*switch>'
        let l:ind = &shiftwidth * 2
    elseif getline(l:lnum) =~# '\v^\s*%(begin|if|else|while|for|function|case)>'
        let l:ind = &shiftwidth
    endif

    if getline(v:lnum) =~# '\v^\s*end>'
        if l:ind ==# 0
            return indent(v:lnum) - &shiftwidth
        else
            return indent(v:lnum) - l:ind
        endif
    elseif getline(v:lnum) =~# '\v^\s*%(case|else)>'
        return indent(v:lnum) - &shiftwidth
    endif

    return indent(l:lnum) + l:ind
endfunction
