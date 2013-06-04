if exists('g:loaded_syntastic_fish_fish_checker')
    finish
endif
let g:loaded_syntastic_fish_fish_checker = 1

function! SyntaxCheckers_fish_fish_IsAvailable()
    return executable('fish')
endfunction

function! SyntaxCheckers_fish_fish_GetLocList()
    let l:makeprg = syntastic#makeprg#build({'exe': 'fish',
                                            \'args': '--no-execute',
                                            \'subchecker': 'fish'})
    return SyntasticMake({'makeprg': l:makeprg,
                         \'errorformat': fish#errorformat()})
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({'filetype': 'fish',
                                                  \'name': 'fish'})
