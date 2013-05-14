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
