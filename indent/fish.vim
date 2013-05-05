setlocal indentexpr=GetFishIndent()
setlocal indentkeys+==end,=else,=case

if exists('*GetFishIndent')
  finish
endif

function GetFishIndent()
  let l:lnum = prevnonblank(v:lnum - 1)

  if l:lnum ==# 0
    return 0
  endif

  let l:ind = indent(l:lnum)

  if getline(l:lnum) =~# '\v^\s*switch>'
    let l:ind = l:ind + &shiftwidth * 2
  elseif getline(l:lnum) =~# '\v^\s*%(begin|if|else|while|for|function|case)>'
    let l:ind = l:ind + &shiftwidth
  endif

  if getline(v:lnum) =~# '\v^\s*case>'
    let l:ind = l:ind - &shiftwidth
  elseif getline(v:lnum) =~# '\v^\s*%(end|else)>'
    let l:ind = indent(l:lnum)
  endif

  return l:ind
endfunction
