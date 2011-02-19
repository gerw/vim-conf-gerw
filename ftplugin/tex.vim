" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2

"" TIP: if you write your \label's as \label{fig:something}, then if you
"" type in \ref{fig: and press <C-n> you will automatically cycle through
"" all the figure labels. Very useful!
"set iskeyword+=:

let g:Tex_HotKeyMappings='align,align*, bmatrix'



" let g:Tex_TEXINPUTS = '~/work/Resources/**,~/work/Talks/**'
" let g:Tex_BIBINPUTS = '~/work/Resources/Bibliography,~/work/Projects/Plasticity/Resources'

"" DEBUG variable:
" let g:Tex_Debug = 1

" Set $BIBINPUTS
let g:Tex_BIBINPUTS = $HOME."/work/Resources/Bibliography/,".$HOME."/work/Projects/Plasticity/Resources/"

" Bildverzeichnis
"let g:Tex_ImageDir = ''

" no Tex-Menus
let g:Tex_Menus = 0

" Do not fold any Environments.
let g:Tex_FoldedEnvironments = ''
" Do not fold \item
let g:Tex_FoldedMisc = 'preamble,<<<'
" Fold all sections, not needed, this is the default.
" let g:Tex_FoldedSections = 'part,chapter,section,subsection,subsubsection,paragraph'




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

" :cnoremap <CR> <C-\>eReplace_space()<CR><CR>
" "" Replace Enter in search to modify search
" function Replace_space()
"   let cmdtype = getcmdtype()
"   let cmd = getcmdline()
"   if (cmdtype == '/' || cmdtype == '?')
"     let cmd = substitute(cmd," ","\\\\_s*","g")
"   endif
"   return cmd
" endfunction


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



" Vervollständigung bei Gleichungsnummerneingabe:
" Zahlen ummappen:
function! NumbersOnLetters()
	call SaveUserMaps("i", "", "aoeiuhdrnslAOEIUHDRNS", "Letters")
	call SaveUserMaps("i", "", "<c-d>", "c_d")
	inoremap a 1
	inoremap o 2
	inoremap e 3
	inoremap i 4
	inoremap u 5
	inoremap h 6
	inoremap d 7
	inoremap r 8
	inoremap n 9
	inoremap s 0
	inoremap A a
	inoremap O o
	inoremap E e
	inoremap I i
	inoremap U u
	inoremap H h
	inoremap D d
	inoremap R r
	inoremap N n
	inoremap S s
	inoremap <esc> <c-r>=LettersOnLetters()<cr><esc>
	imap <c-d> <c-r>=LettersOnLetters()<cr><Plug>IMAP_JumpForward<f9>
	return ''
endfunction

function! LettersOnLetters()
	call RestoreUserMaps("Letters")
	call RestoreUserMaps("c_d")
	" iunmap <esc>
	" imap <c-d> <Plug>IMAP_JumpForward
	return ''
endfunction

" In .vim/after/ftplugin/tex.vim:
" call IMAP("((","\<C-\>\<C-N>:call NumbersOnLetters()\<CR>a(<++>)<++>","tex")
" call IMAP ('\{\}', '\{<++>\}<++>', "tex")
" call IMAP ('\{}', '\{<++>\}<++>', "tex")











" Pfad für Übungen setzen.
if ( getcwd() =~ "WS2009_Chemnitz_Grundlagen_der_Optimierung/Übungen" )
	set path+=~/work/Teaching/WS2009_Chemnitz_Grundlagen_der_Optimierung/Übungen/Aufgaben
endif

" Pfad für Übungen setzen.
if ( getcwd() =~ "work/Teaching/" )
	set path+=~/work/Teaching/Exercises
endif

" Pfad für Plasticity setzen.
if ( getcwd() =~ "Projects/Plasticity" )
	set path+=~/work/Projects/Plasticity/Resources
endif

set path+=~/work/Resources/Bibliography
set path+=~/work/Resources/LaTeX/ 


" Environments:
let g:Tex_Env_block = "\\begin{block}{<++>}\<CR><++>\<CR>\\end{block}"
let g:Tex_Env_frame = "\\begin{frame}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}"

let g:Tex_Env_labelprefix_assumption = "asm:"
let g:Tex_Env_labelprefix_definition = "def:"
let g:Tex_Env_labelprefix_lemma = "lem:"
let g:Tex_Env_labelprefix_remark = "rem:"
let g:Tex_Env_labelprefix_theorem = "thm:"

let g:Tex_Env_labelprefix_align = "eq:"
let g:Tex_Env_labelprefix_equation = "eq:"
let g:Tex_Env_labelprefix_subequations = "eq:"

" No concealing in TeX
let g:tex_conceal = ""

" Doesn't work with numbers:
" noremap <silent> <c-9> i\left<esc>
" noremap <silent> <c-0> i\right<esc>


" Forward Search
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'synctex_wrapper'

" Map Ctrl+Enter => Underline current line with %====
nnoremap <c-cr> zvo<c-r>="%".substitute(getline(line(".")-1),".","=","g")<CR><BS><ESC>^
