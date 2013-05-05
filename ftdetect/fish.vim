autocmd BufRead,BufNewFile *.fish setfiletype fish
autocmd BufRead,BufNewFile /tmp/fish_funced_*.fish /^function\>/+1 | startinsert!
