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
    let l:errorformat = '%Afish: %m,%-Z%f (line %l):%s'
    return SyntasticMake({'makeprg': l:makeprg, 'errorformat': l:errorformat})
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({'filetype': 'fish',
                                                  \'name': 'fish'})
