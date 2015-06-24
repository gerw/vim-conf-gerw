" Vim filetype plugin file
" Language:	matlab
" Maintainer:	Fabrice Guy <fabrice.guy at gmail dot com>
" Last Changed: 2008 Oct 16

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo-=C

if exists("loaded_matchit")
  let s:conditionalEnd = '\(([^()]*\)\@!\<end\>\([^()]*)\)\@!'
  let b:match_words = '\<classdef\>\|\<methods\>\|\<events\>\|\<properties\>\|\<if\>\|\<while\>\|\<for\>\|\<switch\>\|\<try\>\|\<function\>:' . s:conditionalEnd
endif

setlocal suffixesadd=.m
setlocal suffixes+=.asv
" Change the :browse e filter to primarily show M-files
if has("gui_win32") && !exists("b:browsefilter")
  let  b:browsefilter="M-files (*.m)\t*.m\n" .
	\ "All files (*.*)\t*.*\n"
endif

let b:undo_ftplugin = "setlocal suffixesadd< suffixes< "
      \ . "| unlet! b:browsefilter"
      \ . "| unlet! b:match_words"

let &cpo = s:save_cpo

" The matlab Connection
nnoremap \d :call MatlabRun(0)<CR>
vnoremap \d <c-\><c-n>:call MatlabRun(1)<CR>
nnoremap \f :call FindMatlab()<CR>
nnoremap \g :call SelectMatlab()<CR>

function! FindMatlab()
	" Find window number of first matlab
	let xdooutput = system("xdotool search --name XMATLAB | head -n 1")
	" Strip some whitespace
	let b:number = substitute(xdooutput, '^\_s*\(.\{-}\)\_s*$', '\1', '')
endfunction

function! SelectMatlab()
	" Find window number of first matlab
	let xdooutput = system("xdotool selectwindow")
	" Strip some whitespace
	let b:number = substitute(xdooutput, '^\_s*\(.\{-}\)\_s*$', '\1', '')
endfunction

" from
" http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! s:get_visual_selection()
	" Why is this not a built-in Vim script function?!
	" Get lines and cols of selection
	let [lnum1, col1] = getpos("'<")[1:2]
	let [lnum2, col2] = getpos("'>")[1:2]
	" Sometimes, they are not sorted!
	let [lnum1, lnum2] = [min([lnum1,lnum2]), max([lnum1,lnum2])]
	let [col1, col2] = [min([col1,col2]), max([col1,col2])]
	let lines = getline(lnum1, lnum2)
	" If visualmode was v or , strip some lines.
	if visualmode() ==# "v"
		let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
		let lines[0] = lines[0][col1 - 1:]
	elseif visualmode() ==# ""
		for i in range(len(lines))
			let lines[i] = lines[i][col1 - 1 : col2 - (&selection == 'inclusive' ? 1 : 2)]
		endfor
	end
	return join(lines, "\n")
endfunction

function! MatlabRun(visualmode)
	if exists('b:number')
		if !a:visualmode
			" Execute current line.
			let text = getline(".")
		else
			" Execute selection.
			let text = s:get_visual_selection()
		endif

		" Can't use shellescape() here, since it also escapes newlines.
		let escaped_text = substitute(text, "'", "'\\\\''", "g") . "\n"
		call system("xdotool type --delay 0 --window " . b:number .  " '" . escaped_text . "'")
	endif
endfunction
