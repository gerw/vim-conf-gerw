func! Focus(command, vim_command, key)
  let oldw = winnr()
  silent exe 'wincmd ' . a:vim_command
  let neww = winnr()
  if oldw == neww
    if hostname()=="cantor" || hostname()=="kunigunde"
      silent exe '!i3-msg -q focus ' . a:command
    else
      silent exe '!xdotool key --delay 0 ' . a:key
    end

    if !has("gui_running")
        redraw!
    endif
  endif
endfunction

" Focus!
nmap <silent> <F16> :call Focus('left', 'h','F21')<CR>
nmap <silent> <F17> :call Focus('down', 'j','F22')<CR>
nmap <silent> <F18> :call Focus('up',   'k','F23')<CR>
nmap <silent> <F19> :call Focus('right','l','F24')<CR>

imap <silent> <F16> <C-O>:call Focus('left', 'h','F21')<CR>
imap <silent> <F17> <C-O>:call Focus('down', 'j','F22')<CR>
imap <silent> <F18> <C-O>:call Focus('up',   'k','F23')<CR>
imap <silent> <F19> <C-O>:call Focus('right','l','F24')<CR>

vmap <silent> <F16> :<C-U>call Focus('left', 'h','F21')<CR>gv
vmap <silent> <F17> :<C-U>call Focus('down', 'j','F22')<CR>gv
vmap <silent> <F18> :<C-U>call Focus('up',   'k','F23')<CR>gv
vmap <silent> <F19> :<C-U>call Focus('right','l','F24')<CR>gv
