func! Focus(command,vim_command)
  let oldw = winnr()
  silent exe 'wincmd ' . a:vim_command
  let neww = winnr()
  if oldw == neww
    if $HOST=="cantor" || $HOST=="kunigunde"
      silent exe '!i3-msg -q focus ' . a:command
    else
      silent exe '!xdotool key --delay 0 --clearmodifiers alt+shift+ctrl+' . a:vim_command
    end

    if !has("gui_running")
        redraw!
    endif
  endif
endfunction

" Focus!
nmap <silent> gwl :call Focus('right','l')<CR>
nmap <silent> gwh :call Focus('left','h')<CR>
nmap <silent> gwk :call Focus('up','k')<CR>
nmap <silent> gwj :call Focus('down','j')<CR>
