" File: ftplugin/fishprofile.vim
" Author: Kevin Ballard
" Description: Filetype plugin for fish profile files
" Last Change: Jul 09, 2014

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

" Functions {{{1

" This function can't be script-local, it doesn't work when recalculating. I
" don't know why that is.
function! FishProfileFoldExpr(lnum)
	let len = strlen(matchstr(getline(a:lnum), '\d*\t\d*\t\zs-*>'))
	return len ? '>'.len : '='
endfunction

" This function can't be script-local, apparently that just doesn't work.
function! FishProfileFoldText(foldstart, foldend) " {{{
	let line = getline(a:foldstart)

	" expand tabs into spaces
	while 1
		let idx = stridx(line, "\t")
		if idx == -1
			break
		endif
		let width = strdisplaywidth("\t", idx)
		let line = strpart(line, 0, idx) . repeat(" ", width) . line[idx+1:]
	endwhile

	let numlines = a:foldend - a:foldstart + 1
	return line . '… (' . numlines . ')'
endfunction " }}}

" Variables {{{1

setlocal foldmethod=expr
setlocal foldexpr=FishProfileFoldExpr(v:lnum)
setlocal foldlevel=0
setlocal foldtext=FishProfileFoldText(v:foldstart,v:foldend)

setlocal tabstop=8

" }}}1

" Cleanup {{{1

let b:undo_ftplugin = "
			\ setlocal foldexpr< foldmethod< foldlevel< foldtext< tabstop<
			\|delfunction FishProfileFoldExpr
			\|delfunction FishProfileFoldText
			\"

" }}}1

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set noet sw=4 ts=4 sts=4:
