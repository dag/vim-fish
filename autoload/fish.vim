function! fish#Indent()
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

function! fish#Complete(findstart, base)
    if a:findstart
        return getline('.') =~# '\v^\s*$' ? -1 : 0
    else
        if a:base ==# ''
            return []
        endif
        let l:results = []
        let l:completions =
                    \ system('fish -c "complete -C'.shellescape(a:base).'"')
        let l:cmd = substitute(a:base, '\v\S+$', '', '')
        for l:line in split(l:completions, '\n')
            let l:tokens = split(l:line, '\t')
            call add(l:results, {'word': l:cmd.l:tokens[0],
                                \'abbr': l:tokens[0],
                                \'menu': get(l:tokens, 1, '')})
        endfor
        return l:results
    endif
endfunction
