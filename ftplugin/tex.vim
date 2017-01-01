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



" let g:Tex_TEXINPUTS = '~/work/Resources/**,~/work/Talks/**'
" let g:Tex_BIBINPUTS = '~/work/Resources/Bibliography,~/work/Projects/Plasticity/Resources'

"" DEBUG variable:
" let g:SyntaxFolds_Debug = 1
" let g:Tex_Debug = 1
" let g:Imap_Debug = 1
" let g:Tex_DebugLog = "vim-latex-suite.log"

" Set $BIBINPUTS
let g:Tex_BIBINPUTS = $HOME."/work/Resources/Bibliography/,".$HOME."/work/Projects/Plasticity/Resources/"

" Bildverzeichnis
"let g:Tex_ImageDir = ''

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


" Which warnings should be ignored? None.
let g:Tex_IgnoreLevel = 0


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
	" Prevent double-remapping
	call RestoreUserMaps("Letters")
	call RestoreUserMaps("c_d")
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
	imap <c-d> <c-r>=LettersOnLetters()<cr><Plug>IMAP_JumpForward<C-G>u<f9>
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


""""" Macros for Creating of Environments:

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

" Customized Section maps
let g:Tex_SectionMaps = 0
call IMAP("SPA", "\\part{<+name+>}\<CR>%%fakechapter: Intro\<CR>\\label{part:<+label+>}\<CR><++>", "tex")
call IMAP("SCH", "\\chapter{<+name+>}\<CR>%%fakesection: Intro\<CR>\\label{chap:<+label+>}\<CR><++>", "tex")
call IMAP("SSE", "\\section{<+name+>}\<CR>%%fakesubsection: Intro\<CR>\\label{sec:<+label+>}\<CR><++>", "tex")
call IMAP("SSS", "\\subsection{<+name+>}\<CR>%%fakesubsubsection: Intro\<CR>\\label{subsec:<+label+>}\<CR><++>", "tex")
call IMAP("SS2", "\\subsubsection{<+name+>}\<CR>%%fakeparagraph: Intro\<CR>\\label{sssec:<+label+>}\<CR><++>", "tex")
call IMAP("SPG", "\\paragraph{<+name+>}\<CR><++>", "tex")
call IMAP("SSP", "\\subparagraph{<+name+>}\<CR><++>", "tex")

" Subequations environment
call IMAP("ESE", "\<C-r>=Tex_PutEnvironment('subequations')\<CR>", 'tex')

" Block and frame environment in beamer
let g:Tex_Env_block = "\\begin{block}{<++>}\<CR><++>\<CR>\\end{block}\<CR><++>"
let g:Tex_Env_frame = "\\begin{frame}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}\<CR><++>"
call IMAP("EBL", g:Tex_Env_block, "tex")
" call IMAP("EFR", g:Tex_Env_frame, "tex") " in after/ftplugin/tex.vim

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



" Some useful macros
" -----------------------------------
" \added[...]{text} -> text
let @b='dt{ma%x`ax'
" \deleted[...]{text} -> 
let @e='dt{daB'
" \replaced[...]{text1}{text2} -> text1
let @s='dt{ma%xldaB`ax'


" Use other placeholders, that does not collide with LaTeXs beamer
let g:Imap_PlaceHolderStart = '<<+'
let g:Imap_PlaceHolderEnd = '+>>'

" <S-ESC> in insert mode: insert a placeholder and leave insert mode
imap <buffer><silent> <S-ESC> <<++>><ESC>


" Spelling of difficult names
call IMAP("Frechet", "Fréchet", "tex")
call IMAP("Gateaux", "Gâteaux", "tex")
