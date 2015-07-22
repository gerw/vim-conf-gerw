func! Focus(command, vim_command, key)
  let oldw = winnr()
  silent exe 'wincmd ' . a:vim_command
  let neww = winnr()
  if oldw == neww
    if hostname()=="cantor" || hostname()=="kunigunde"
      silent exe '!i3-msg -q focus ' . a:command
    else
      silent exe '!xdotool key --delay 0 --clearmodifiers alt+' . a:key
    end

    if !has("gui_running")
        redraw!
    endif
  endif
endfunction

" Focus!
nmap <silent> gwh :call Focus('left', 'h','F21')<CR>
nmap <silent> gwj :call Focus('down', 'j','F22')<CR>
nmap <silent> gwk :call Focus('up',   'k','F23')<CR>
nmap <silent> gwl :call Focus('right','l','F24')<CR>
