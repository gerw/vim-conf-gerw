" Indentation options:
set cindent
set cino=g0


" Zum Header wechseln:
" map <F4> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>
map <silent> <F4> :call Switch_header_impl()<CR>:redraw<CR>

if !exists("*Switch_header_impl")
	"" Prevent redefining this function
	"" (if editing a new c-file, ftplugin/cpp.vim will be sourced again!)

	function! Switch_header_impl()
		let filename = expand('%')
		let basename = expand('%:r')

		if filename =~? '\.h\%(pp\)\?$'
			" We are currently editing a header file
			let extension = 'c'
		elseif filename =~? '\.c\%(pp\|c\)\?$'
			" We are currently editing an implementation file
			let extension = 'h'
		else
			return ''
		end

		" echoerr filename
		" echoerr basename . '.' . extension

		if filereadable( basename . '.' . extension )
			let newfile = basename . '.' . extension 
			" echoerr newfile
			execute "normal :e " . newfile . "\<cr>"
		elseif filereadable( basename . '.' . extension . 'pp' )
			let newfile = basename . '.' . extension . 'pp'
			" echoerr newfile
			execute "normal :e " . newfile . "\<cr>"
		elseif filereadable( basename . '.' . extension . 'c' )
			let newfile = basename . '.' . extension . 'c'
			" echoerr newfile
			execute "normal :e " . newfile . "\<cr>"
		end
	endfunction
endif



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
