if exists('g:loaded_syntastic_fish_fish_checker')
    finish
endif
let g:loaded_syntastic_fish_fish_checker = 1

function! SyntaxCheckers_fish_fish_GetLocList() dict
    let l:makeprg = self.makeprgBuild({'args': '--no-execute'})
    return SyntasticMake({'makeprg': l:makeprg,
                         \'errorformat': fish#errorformat()})
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({'filetype': 'fish',
                                                  \'name': 'fish'})
