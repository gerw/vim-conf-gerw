func! Focus(comando,vim_comando)
  let oldw = winnr()
  silent exe 'wincmd ' . a:vim_comando
  let neww = winnr()
  if oldw == neww
    silent exe '!i3-msg -q focus ' . a:comando
    if !has("gui_running")
        redraw!
    endif
  endif
endfunction

" Focus!
map <silent> gwl :call Focus('right','l')<CR>
map <silent> gwh :call Focus('left','h')<CR>
map <silent> gwk :call Focus('up','k')<CR>
map <silent> gwj :call Focus('down','j')<CR>
