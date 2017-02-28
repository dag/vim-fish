if exists('loaded_vim_fish_plugin') | finish | endif
let loaded_vim_fish_plugin = 1

function! s:FishIndent(line1,line2)
	" Save the cursor position
	let l:save_cursor = getpos(".")

	silent! execute ':' . a:line1 . ',' . a:line2 . '!fish_indent'

	" Restore the cursor position
	call setpos('.', l:save_cursor)
endfunction

command! -range=% FishIndent call <SID>FishIndent(<line1>,<line2>)
