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
        if getline('.') =~# '\v^\s*$'
            return -1
        else
            return 0
        endif
    else
        let l:results = []
        let l:completions = system('fish -c "complete -C'.shellescape(a:base).'"')
        let l:cmd = substitute(a:base, '\v<\S*$', '', '')
        for l:line in split(l:completions, '\n')
            let l:tokens = split(l:line, '\t')
            let l:completion = l:cmd.l:tokens[0]
            let l:item = {'word': l:completion, 'abbr': l:tokens[0]}
            if len(l:tokens) ==# 2
                let l:item['menu'] = l:tokens[1]
            endif
            call add(l:results, l:item)
        endfor
        return l:results
    endif
endfunction
