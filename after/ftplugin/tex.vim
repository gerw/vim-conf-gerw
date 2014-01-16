" matchit matcht auch \left und \right
if exists("loaded_matchit")
  let b:match_words .= ',\\left\>:\\right\>'
endif " exists("loaded_matchit")


" Auch die Bibliographien editieren:
set suffixesadd+=.bib,.sty,.cls


" Vervollständigung bei Gleichungsnummerneingabe
call IMAP("((","\<C-\>\<C-N>:call NumbersOnLetters()\<CR>a(<++>)<++>","tex")

" Hilfe bei Klammern:
call IMAP ('\{\}', '\{<++>\}<++>', "tex")
call IMAP ('\{}', '\{<++>\}<++>', "tex")
call IMAP ('\left()', '\left( <++> \right)<++>', "tex")
call IMAP ('\left\{\}', '\left\{ <++> \right\}<++>', "tex")
call IMAP ('\left\{}', '\left\{ <++> \right\}<++>', "tex")
call IMAP ('\left[]', '\left[ <++> \right]<++>', "tex")

" Set up IMAP commands for \Bigh() and co.
for type in ['big', 'Big', 'bigg', 'Bigg', 'var', 'normal']
	for bracket in ['()', '[]', '\{\}']
		call IMAP (type . 'h' . bracket, type . 'h' . bracket . '{<++>}', "tex")
	endfor
	" And some special curlies
	call IMAP (type . 'h' . '{}', type . 'h' . '\{\}' . '{<++>}', "tex")
	call IMAP (type . 'h' . '\{}', type . 'h' . '\{\}' . '{<++>}', "tex")
endfor


" remove binding to <m-i> = é
silent! iunmap <buffer> <m-i>
let v:errmsg = ''


"" Add graphicx to the detected packages (such that EFI uses \includegraphics)
if !exists("g:Tex_package_detected")
	let g:Tex_package_detected = 'graphicx'
elseif g:Tex_package_detected !~ '\<graphicx\>'
	let g:Tex_package_detected = g:Tex_package_detected.',graphicx'
endif
