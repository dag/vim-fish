autocmd BufRead,BufNewFile *.fish setfiletype fish
autocmd BufRead,BufNewFile /tmp/fish_funced_*.fish /^function\>/+1 | startinsert!
autocmd BufRead,BufNewFile ~/.config/fish/fish_{read_,}history setfiletype yaml
autocmd BufRead,BufNewFile ~/.config/fish/fishd.* setlocal readonly
