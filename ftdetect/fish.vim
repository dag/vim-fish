autocmd BufRead,BufNewFile *.fish setfiletype fish
autocmd BufRead fish_funced_*_*.fish ?\C^end\>?-1 | if getline('.') ==# '' | execute "normal! i\<C-t>" | endif | startinsert!
autocmd BufRead,BufNewFile ~/.config/fish/fish_{read_,}history setfiletype yaml
autocmd BufRead,BufNewFile ~/.config/fish/fishd.* setlocal readonly
autocmd BufNewFile ~/.config/fish/*.fish call append(0, ['function '.expand('%:t:r'), repeat(' ', &shiftwidth), 'end']) | 4delete | 2 | startinsert!
