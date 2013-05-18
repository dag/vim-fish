autocmd BufRead,BufNewFile *.fish setfiletype fish
autocmd BufRead /tmp/fish_funced_*.fish ?\C^end\>?-1 | if getline('.') ==# '' | execute "normal! i\<C-t>" | endif | startinsert!
autocmd BufRead,BufNewFile ~/.config/fish/fish_{read_,}history setfiletype yaml
autocmd BufRead,BufNewFile ~/.config/fish/fishd.* setlocal readonly
