" matchit matcht auch \left und \right
if exists("loaded_matchit")
  let b:match_words .= ',\\left\>:\\right\>'
endif " exists("loaded_matchit")


" Auch die Bibliographien editieren:
set suffixesadd+=.bib,.sty,.cls


" Vervollständigung bei Gleichungsnummerneingabe
call IMAP("((","\<C-\>\<C-N>:call NumbersOnLetters()\<CR>a(<++>)<++>","tex")
call IMAP ('\{\}', '\{<++>\}<++>', "tex")
call IMAP ('\{}', '\{<++>\}<++>', "tex")


" remove binding to <m-i> = é
iunmap <buffer> <m-i>
