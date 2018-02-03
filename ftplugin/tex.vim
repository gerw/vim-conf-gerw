" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2

"" TIP: if you write your \label's as \label{fig:something}, then if you
"" type in \ref{fig: and press <C-n> you will automatically cycle through
"" all the figure labels. Very useful!
"set iskeyword+=:

" In Tex-files, "_" is not to be considered as a keyword character.
set iskeyword-=_

let g:Tex_HotKeyMappings='align,align*, bmatrix'


"" DEBUG variable:
" let g:SyntaxFolds_Debug = 1
" let g:Tex_Debug = 1
" let g:Imap_Debug = 1
" let g:Tex_DebugLog = "vim-latex-suite.log"

" Which command should be used for completed references?
let g:Tex_RefCompletionCommand = "cref"

" no Tex-Menus
let g:Tex_Menus = 0
" Do not scan for packages. This is slow and we don't need it.
let g:Tex_PackagesMenu = 0

" Customize template directory
let g:Tex_CustomTemplateDirectory = '~/work/Resources/LaTeX/Templates'

" Do not fold any Environments.
let g:Tex_FoldedEnvironments = ''
" Do not fold \item
let g:Tex_FoldedMisc = 'preamble,<<<'
" Fold all sections.
let g:Tex_FoldedSections = 'part|addpart,chapter|addchap,section|addsec,subsection,subsubsection,paragraph,subparagraph'

" No concealing in TeX
let g:tex_conceal = ""

" Which warnings should be ignored? None.
let g:Tex_IgnoreLevel = 0

" Smart spaces in command mode {{{
:cnoremap <space> <C-R>=Replace_space()<CR>
"" Replace spaces in search to map also line breaks
function! Replace_space()
	let cmdtype = getcmdtype()
	if cmdtype == '/' || cmdtype == '?'
		return "\\_s*"
	else
		return " "
	endif
endfunction

:cnoremap <backspace> <C-R>=Replace_backspace()<CR>
"" Replace backspaces in search to delete "\_s*"
function! Replace_backspace()
	let cmdtype = getcmdtype()
	if (cmdtype == '/' || cmdtype == '?')
		let cmdline = getcmdline()
		let cmdpos = getcmdpos()
		if ( cmdline[cmdpos-5 : cmdpos-2] == "\\_s*" )
			return ""
		else
			return ""
		endif
	else
		return ""
	endif
endfunction
"}}}
" Helper for beamer talks {{{
noremap <silent> <c-n> :call ToggleCurrent()<CR>
"" Toogle [label=current] in beamer.
function! ToggleCurrent()
	let line = getline('.')
	if ( line =~ "^\\s*\\\\begin{frame}.*\\[label=\\w*\\]$" )
		normal ^f[D
	elseif ( line =~ "^\\s*\\\\begin{frame}")
		normal A[label=current]
	else
		" call search("^\\s*\\\\begin{frame}")
	endif
endfunction

"" Move to next / previous frame
noremap <silent> <c-j> :call search("^\\s*\\\\begin{frame}")<cr>
noremap <silent> <c-k> k:call search("^\\s*\\\\begin{frame}",'cb')<cr>
"}}}
" Smart tab for file completion {{{
:inoremap <expr> <tab> SmartTab()
"" Replace tab => search for files, if line start with \input{
function! SmartTab()
	let include = matchstr(getline('.'), '^\s*\\input{')
	if include != ''
		return "\<c-x>\<c-f>"
	else
		return "\<tab>"
	endif
endfunction
"}}}
" Numbers on letters for equations {{{
" Vervollständigung bei Gleichungsnummerneingabe:
" Zahlen ummappen:
function! NumbersOnLetters()
	" Prevent double-remapping
	call RestoreUserMaps("Letters")
	call SaveUserMaps("bi", "", "aoeiuhdrnslAOEIUHDRNS", "Letters")
	inoremap <buffer> a 1
	inoremap <buffer> o 2
	inoremap <buffer> e 3
	inoremap <buffer> i 4
	inoremap <buffer> u 5
	inoremap <buffer> h 6
	inoremap <buffer> d 7
	inoremap <buffer> r 8
	inoremap <buffer> n 9
	inoremap <buffer> s 0
	inoremap <buffer> A a
	inoremap <buffer> O o
	inoremap <buffer> E e
	inoremap <buffer> I i
	inoremap <buffer> U u
	inoremap <buffer> H h
	inoremap <buffer> D d
	inoremap <buffer> R r
	inoremap <buffer> N n
	inoremap <buffer> S s
	inoremap <buffer> <esc> <c-r>=LettersOnLetters()<cr><esc>
	imap <buffer> <c-d> <c-r>=LettersOnLetters()<cr><Plug>IMAP_JumpForward<C-G>u<f9>
	return ''
endfunction

function! LettersOnLetters()
	call RestoreUserMaps("Letters")
	iunmap <buffer> <esc>
	iunmap <buffer> <c-d>
	return ''
endfunction

" In .vim/after/ftplugin/tex.vim:
" call IMAP("((","\<C-\>\<C-N>:call NumbersOnLetters()\<CR>a(<++>)<++>","tex")
" call IMAP ('\{\}', '\{<++>\}<++>', "tex")
" call IMAP ('\{}', '\{<++>\}<++>', "tex")

"}}}
" Adjust path, Tex_TEXINPUTS and Tex_BIBINPUTS {{{
" Pfad für Übungen setzen.
if ( getcwd() =~ "WS2009_Chemnitz_Grundlagen_der_Optimierung/Übungen" )
	set path+=$HOME/work/Teaching/WS2009_Chemnitz_Grundlagen_der_Optimierung/Übungen/Aufgaben
endif

" Pfad für Übungen setzen.
if ( getcwd() =~ "work/Teaching/" )
	set path+=$HOME/work/Teaching/Exercises
endif

" Pfad für Plasticity setzen.
if ( getcwd() =~ "Projects/Plasticity" )
	set path+=$HOME/work/Projects/Plasticity/Resources
endif

" Pfad für Talks setzen.
if ( getcwd() =~ "work/Talks" )
	set path+=$HOME/work/Talks/Archive
endif

set path+=$HOME/work/Resources/Bibliography
set path+=$HOME/work/Resources/LaTeX/ 

let g:Tex_TEXINPUTS = $HOME . '/work/Resources/LaTeX/,' . $HOME . '/work/Talks/Archive/**/*'

" Set $BIBINPUTS
let g:Tex_BIBINPUTS = $HOME."/work/Resources/Bibliography/,".$HOME."/work/Projects/Plasticity/Resources/"
"}}}
" Customization of Environments {{{

" Customization of labels of environments
let g:Tex_EnvLabelprefix_assumption = "asm:"
let g:Tex_EnvLabelprefix_definition = "def:"
let g:Tex_EnvLabelprefix_lemma = "lem:"
let g:Tex_EnvLabelprefix_remark = "rem:"
let g:Tex_EnvLabelprefix_theorem = "thm:"
let g:Tex_EnvLabelprefix_corollary = "cor:"
let g:Tex_EnvLabelprefix_proposition = "prop:"

let g:Tex_EnvLabelprefix_align = "eq:"
let g:Tex_EnvLabelprefix_equation = "eq:"
let g:Tex_EnvLabelprefix_subequations = "eq:"

let g:Tex_Env_lemdef = "\\begin{lemdef}\<CR>\\label{lemdef:<+label+>}\<CR><+content+>\<CR>\\end{lemdef}\<CR><++>"
let g:Tex_Env_example = "\\begin{example}\<CR>\\label{ex:<+label+>}\<CR><+content+>\<CR>\\end{example}\<CR><++>"
let g:Tex_Env_algorithm = "\\begin{algorithm}[<+title+>]\\hfill\\par\<CR>\\label{alg:<+label+>}\<CR>\\begin{algorithmic}[1]\<CR>\\REQUIRE <+input+>\<CR>\\ENSURE <+output+>\<CR>\\end{algorithmic}\<CR>\\end{algorithm}\<CR><++>"

" Created environments should end in <CR>+<++>
let g:Tex_EnvEndWithCR = 1
" Created labels before or after content?
let g:Tex_LabelAfterContent = 0
" Inserted items should include CR
let g:Tex_ItemsWithCR = 1
" }}}
" Customized Section maps {{{
let g:Tex_SectionMaps = 0
call IMAP("SPA", "\\part{<+name+>}\<CR>%%fakechapter: Intro\<CR>\\label{part:<+label+>}\<CR><++>", "tex")
call IMAP("SCH", "\\chapter{<+name+>}\<CR>%%fakesection: Intro\<CR>\\label{chap:<+label+>}\<CR><++>", "tex")
call IMAP("SSE", "\\section{<+name+>}\<CR>%%fakesubsection: Intro\<CR>\\label{sec:<+label+>}\<CR><++>", "tex")
call IMAP("SSS", "\\subsection{<+name+>}\<CR>%%fakesubsubsection: Intro\<CR>\\label{subsec:<+label+>}\<CR><++>", "tex")
call IMAP("SS2", "\\subsubsection{<+name+>}\<CR>%%fakeparagraph: Intro\<CR>\\label{sssec:<+label+>}\<CR><++>", "tex")
call IMAP("SPG", "\\paragraph{<+name+>}\<CR><++>", "tex")
call IMAP("SSP", "\\subparagraph{<+name+>}\<CR><++>", "tex")
"}}}
" Block and frame environment in beamer {{{
let g:Tex_Env_block = "\\begin{block}{<++>}\<CR><++>\<CR>\\end{block}\<CR><++>"
let g:Tex_Env_frame = "\\begin{frame}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}\<CR><++>"
call IMAP("EBL", g:Tex_Env_block, "tex")
" call IMAP("EFR", g:Tex_Env_frame, "tex") " in after/ftplugin/tex.vim
"}}}

" Forward Search
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'synctex_wrapper'

" Map Ctrl+Enter => Underline current line with %====
nnoremap <c-cr> zvo<c-r>="%".substitute(getline(line(".")-1),".","=","g")<CR><BS><ESC>^


" Create word objects {{{

" Inline-math text objects (similar to "aw" [a word] and "iw" [inner word])
" a$ selects / use including limiting $
" i$ selects / use excluding limiting $
" BUG / FEATURE:
" If you have "$1+1$ here is the cursor $2+2$", then "da$" results in "$1+12+2$"
onoremap <silent> i$ :<c-u>normal! T$vt$<cr>
onoremap <silent> a$ :<c-u>normal! F$vf$<cr>
vnoremap <silent> i$ :<c-u>normal! T$vt$<cr>
vnoremap <silent> a$ :<c-u>normal! F$vf$<cr>


" Text objects corresponding to latex environments
onoremap <silent>ae :<C-u>call LatexEnvironmentTextObject(0)<CR>
onoremap <silent>ie :<C-u>call LatexEnvironmentTextObject(1)<CR>
vnoremap <silent>ae :<C-u>call LatexEnvironmentTextObject(0)<CR>
vnoremap <silent>ie :<C-u>call LatexEnvironmentTextObject(1)<CR>

function! LatexEnvironmentTextObject(inner)
	let b:my_count = v:count
	let b:my_inner = a:inner

	let startstring = '\\begin{\w*\*\?}'
	let endstring = '\\end{\w*\*\?}\zs'
	let skipexpr = ''

	" Determine start of environment
	call searchpair(startstring, '', endstring, 'bcW', skipexpr)
	for i in range( v:count1 - 1)
		call searchpair(startstring, '', endstring, 'bW', skipexpr)
	endfor


	" Start selecting
	normal! V

	" Determine end of environment
	" normal! ^
	call searchpair(startstring, '', endstring, 'W', skipexpr)
	normal! ^

	if a:inner == 1
		normal! ojok
	end

endfunction


" }}}
" Macros for deletion of \added, \deleted and \replaced {{{
" -----------------------------------
" \added[...]{text} -> text
let @b='dt{ma%x`ax'
" \deleted[...]{text} -> 
let @e='dt{daB'
" \replaced[...]{text1}{text2} -> text1
let @s='dt{ma%xldaB`ax'
" }}}

" Use other placeholders, that does not collide with LaTeXs beamer
let g:Imap_PlaceHolderStart = '<<+'
let g:Imap_PlaceHolderEnd = '+>>'

" <S-ESC> in insert mode: insert a placeholder and leave insert mode
imap <buffer><silent> <S-ESC> <<++>><ESC>

" Spelling of difficult names
call IMAP("Frechet", "Fréchet", "tex")
call IMAP("Gateaux", "Gâteaux", "tex")

" Increase and decrease size of delimiters {{{
nnoremap \+ :call DelimDeIncrease(1)
nnoremap + :call DelimDeIncrease(1)
nnoremap \- :call DelimDeIncrease(-1)
nnoremap - :call DelimDeIncrease(-1)
nnoremap \* :call DelimDeIncrease(2)

let b:delims = 'abs\|norm\|paren\|brace\|brack\|innerp\|dual\|set'
let b:sizes = ['', 'big', 'Big', 'bigg', 'Bigg']

function! DelimDeIncrease( direction )
	if DelimFind() > 0
		" Move to end of delimiter
		call search(b:delim_pattern, 'ceW')

		" Get line after cursor
		let line = strpart(getline("."), col("."))

		" Get current size
		let cur_size = matchstr(line, '^\%(\*\|\[\\\zs\w*\ze\]\)')

		if cur_size == "*"
			if a:direction == 1
				" Remove *
				normal! lx
				let offset = -1
			elseif a:direction == -1
				" Replace * by [\biggestsize]
				exec 'normal! lcl[\' . b:sizes[-1] . ']'
				let offset = len(b:sizes[-1]) + 2
			else
				let offset = 0
			endif
		else
			" What we need to issue a replace
			if match(line, '^\%({\|\s\|$\)') >= 0
				let repl = 'a'
				let offset = 2
			else
				let repl = 'lcf]'
				let offset = 0
			end
			let cur_size_idx = index(b:sizes, cur_size)
			if a:direction == 1
				" Replace [size] by [next_size]
				let bigger_size = cur_size_idx + 1
				if bigger_size < len(b:sizes)
					let bigger_size = b:sizes[bigger_size]
					exec 'normal! ' . repl . '[\' . bigger_size . ']'
					let offset += len(bigger_size) - len(cur_size)
					if cur_size == ""
						let offset += 1
					endif
				else
					let offset = 0
				end
			elseif a:direction == -1
				" Replace [size] by [next_size]
				let smaller_size = cur_size_idx - 1
				if smaller_size >= 0
					let smaller_size = b:sizes[smaller_size]
					if smaller_size == ""
						exec 'normal! ' . repl . ''
						let offset += -3 - len(cur_size)
					else
						exec 'normal! ' . repl . '[\' . smaller_size . ']'
						let offset += len(smaller_size) - len(cur_size)
					end
				else
					let offset = 0
				end
			else
				" Replace [size] by *
				exec 'normal! ' . repl . '*'
				let offset += -2 - len(cur_size)
				if cur_size == ""
					let offset += 1
				endif
			endif
		endif
		" Move to end of delimiter
		call search(b:delim_pattern, 'cbeW')
		if b:curpos[1] == line(".") && b:curpos[2] > col(".")
			" In this case, we have to correct the cursor position
			call cursor(b:curpos[1], max([col("."), b:curpos[2] + offset]))
		else
			call setpos('.', b:curpos)
		end
	endif
endfunction

function! DelimFind()
	" This function tries to find the delimiter we want to increase

	" Save cursor position
	let b:curpos = getcurpos()

	" Assemble delimiter pattern
	let b:delim_pattern = '\\\%(' . b:delims . '\)\>'
	let b:delim_pattern_w_size = b:delim_pattern . '\%(\*\|\[\\[Bb]ig*\]\)\?'

	" Check whether pattern matches under the cursor!
	" We search forward, then backward and check whether cursor is in between
	call search( b:delim_pattern_w_size, 'ecW' )
	call search( b:delim_pattern_w_size, 'bcW' )
	let pos = getcurpos()
	if pos[1] == b:curpos[1] && pos[2] <= b:curpos[2]
		return line('.')
	else
		call setpos('.', b:curpos)
	end

	" Searches backwards to the next delimiter command
	if getline('.')[col('.')-1] != '{'
		normal! [{
		if getline('.')[col('.')-1] != '{'
			call setpos('.', b:curpos)
			return 0
		endif
	end
	" Previous non-whitespace character
	call search('\S', 'bW')

	while getline('.')[col('.')-1] == '}'
		normal! [{
		call search('\S', 'bW')
	endwhile

	" Does the delim pattern match?
	let line = strpart(getline("."), 0, col("."))

	if match(line, b:delim_pattern_w_size . '$') != -1
		return search(b:delim_pattern, 'bcW')
	else
		call setpos('.', b:curpos)
		return 0
	end
endfunction

" }}}

" vim:fdm=marker
