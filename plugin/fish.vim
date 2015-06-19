if get(g:, 'loaded_fish', 0)
    finish
endif
let loaded_fish = 1

" Universal variable storages should not be hand edited.
autocmd BufRead,BufNewFile ~/.config/fish/fishd.* setlocal readonly

" Move cursor to first empty line when using funced.
autocmd BufRead fish_funced.* exec "normal! gg=G" | call search('^\s*\zs$')

" Mimic `funced` when manually creating functions.
autocmd BufNewFile ~/.config/fish/functions/*.fish
            \ call setline(1, ['function '.expand('%:t:r'), '', 'end']) | 2
