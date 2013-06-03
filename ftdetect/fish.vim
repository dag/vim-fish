autocmd BufRead,BufNewFile *.fish setfiletype fish

" Detect fish scripts by the shebang line.
autocmd BufRead *
            \ if getline(1) =~# '\v^#!%(\f*/|/usr/bin/env\s*<)fish>' |
            \     setlocal filetype=fish |
            \ endif

" Start Insert inside function edited with `funced`.
autocmd BufRead fish_funced_*_*.fish
            \ ?\C^end\>?-1 |
            \ if getline('.') ==# '' |
            \     execute "normal! i\<C-t>" |
            \ endif |
            \ startinsert!

" Fish histories are YAML documents.
autocmd BufRead,BufNewFile ~/.config/fish/fish_{read_,}history setfiletype yaml

" Universal variable storages should not be hand edited.
autocmd BufRead,BufNewFile ~/.config/fish/fishd.* setlocal readonly

" Mimic `funced` when manually creating functions.
autocmd BufNewFile ~/.config/fish/functions/*.fish
            \ call append(0, ['function '.expand('%:t:r'),
                             \repeat(' ', &shiftwidth),
                             \'end']) |
            \ 4delete | 2 | startinsert!
