" In this file, we set up some customizations for the solarized colorscheme.

if exists("g:loaded_customize_solarized")
	finish
endif
let g:loaded_customize_solarized = 1


function GetHighlight(name)
	redir => output
	exec "highlight" a:name
	redir end
	let format = substitute(output, ".*xxx *", "", "")
	let format = substitute(format, "\n", " ", "g")
	return format
endfunction

function GetFG(name)
	let format = GetHighlight(a:name)
	let ctermfg = matchstr( format, 'ctermfg=\(#\|\w\)*' )
	let guifg = matchstr( format, 'guifg=\(#\|\w\)*' )
	return ctermfg . " " . guifg
endfunction

function FGToBG(format)
	return substitute( a:format, "fg", "bg", "g" )
endfunction

function SwapHighlight(hl1, hl2)
	let s:hl1 = GetHighlight( a:hl1 )
	let s:hl2 = GetHighlight( a:hl2 )

	exec "highlight" a:hl2 s:hl1
	exec "highlight" a:hl1 s:hl2
endfunction

function SetHighlight(group, hl)
	exec "highlight" "clear" a:group
	exec "highlight" a:group a:hl
endfunction

function! CustomizeSolarized()
	if exists("g:colors_name") && g:colors_name == "solarized"

		" Get the blue color.
		let s:blue    = GetFG("Identifier")
		let s:cyan    = GetFG("Constant")
		let s:green   = GetFG("Statement")
		let s:orange  = GetFG("PreProc")
		let s:yellow  = GetFG("Type")
		let s:red     = GetFG("Special")
		let s:violet  = GetFG("Underlined")
		let s:magenta = GetFG("Todo")


		let s:bold = "gui=bold cterm=bold"
		let s:nobold = "gui=NONE cterm=NONE"
		let s:ubold = "gui=bold,underline cterm=bold,underline"
		" let s:statement = GetHighlight("Statement")
		" 
		" exec "highlight" "Statement" s:comment
		" exec "highlight" "Comment  " s:statement

		" call SetHighlight("SpecialKey", s:blue . " " . s:bold )
		call SetHighlight("SpecialKey", s:blue )

		let s:folded = GetHighlight("Folded")
		let s:folded = substitute(s:folded, "underline", "", "g" )
		let s:folded = substitute(s:folded, "\\a*= ", " ", "g" )
		let g:folded = s:folded
		call SetHighlight("Folded", s:folded)
		" call SetHighlight("Folded", s:folded)
		" call SetHighlight("Folded", s:blue . " " . s:ubold )

		call SetHighlight("Error", s:yellow . " " . FGToBG(s:red) )


		" call SwapHighlight("Comment", "Statement")
	endif
endfunction

" Call the function if the colorscheme changes / is reloaded
autocmd ColorScheme * silent call CustomizeSolarized()
" Call the function after startup (the colorscheme autocmd does not apply in
" this situation).
autocmd VimEnter * silent call CustomizeSolarized()
