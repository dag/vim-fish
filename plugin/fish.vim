if get(g:, 'loaded_fish', 0)
    finish
endif
let loaded_fish = 1

" Universal variable storages should not be hand edited.
autocmd BufRead,BufNewFile ~/.config/fish/fishd.*,~/.config/fish/fish_variables
            \ setlocal readonly

" When using funced:
" - Reindent (because funced adds a tab on the first empty line and the user may
"   have set expandtab).
" - Move the cursor to the first empty line.
autocmd BufRead fish_funced.*,fish_funced_*_*.fish,/tmp/fish.*/*.fish
            \ retab | call search('^\s*\zs$')

" Mimic `funced` when manually creating functions.
autocmd BufNewFile ~/.config/fish/functions/*.fish
            \ call setline(1, ['function '.expand('%:t:r'), '', 'end']) | 2

command! -nargs=? FishHelp call fish#Help(<q-args>)
