" Indentation options:
set cino=g0


" Zum Header wechseln:
map <F4> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>

map <silent> <F5> :call Make_cpp_env()<CR><home><Plug>IMAP_JumpForward
imap <silent> <F5> <esc><f5>

function! Make_cpp_env()
	let env = matchstr(getline('.'), '^\s*\zs\w\+\ze\s*$')
	if env == 'for'
		normal ccfor( <++>; <++>; <++>) {
		normal o<++>
		normal o}
		normal o<++>
		exe "normal \<up>%"
		" call cursor()
	elseif env == 'if'
	elseif env == 'while'
	endif
endfunction


:inoremap <expr> <tab> SmartTab()
"" Replace spaces in search to map also line breaks
function! SmartTab()
	let include = matchstr(getline('.'), '^#include')
	if include != ''
		return "\<c-x>\<c-f>"
	else
		return "\<tab>"
	endif
endfunction


fun! ShowName()
	let lnum = line(".")
	let col = col(".")
	let line = getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'cbW'))
	echohl ModeMsg
	if matchstr(line, "class") == ''
		echo matchstr(line, "^[^(]*")
	else
		call search("\\%" . lnum . "l" . "\\%" . col . "c")
		let region=matchstr(getline(search('^\S','cbW')),"[^:]*")
		if region=='{'
			let region='private'
		end
		echo join([matchstr(line, '\w*\(\s\+\w\+\)\+'),', ', region ],'')
	end
	echohl None
	call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

map <F6> :call ShowName() <CR>
