function! fish#Indent()
    let l:prevlnum = prevnonblank(v:lnum - 1)
    if l:prevlnum ==# 0
        return 0
    endif
    let l:indent = 0
    let l:prevline = getline(l:prevlnum)
    if l:prevline =~# '\v^\s*switch>'
        let l:indent = &shiftwidth * 2
    elseif l:prevline =~# '\v^\s*%(begin|if|else|while|for|function|case)>'
        let l:indent = &shiftwidth
    endif
    let l:line = getline(v:lnum)
    if l:line =~# '\v^\s*end>'
        return indent(v:lnum) - (l:indent ==# 0 ? &shiftwidth : l:indent)
    elseif l:line =~# '\v^\s*%(case|else)>'
        return indent(v:lnum) - &shiftwidth
    endif
    return indent(l:prevlnum) + l:indent
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
