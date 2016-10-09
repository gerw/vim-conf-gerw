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
nnoremap <silent> <F16> :call Focus('left', 'h','F21')<CR>
nnoremap <silent> <F17> :call Focus('down', 'j','F22')<CR>
nnoremap <silent> <F18> :call Focus('up',   'k','F23')<CR>
nnoremap <silent> <F19> :call Focus('right','l','F24')<CR>

inoremap <silent> <F16> <C-O>:call Focus('left', 'h','F21')<CR>
inoremap <silent> <F17> <C-O>:call Focus('down', 'j','F22')<CR>
inoremap <silent> <F18> <C-O>:call Focus('up',   'k','F23')<CR>
inoremap <silent> <F19> <C-O>:call Focus('right','l','F24')<CR>

vnoremap <silent> <F16> :<C-U>call Focus('left', 'h','F21')<CR>gv
vnoremap <silent> <F17> :<C-U>call Focus('down', 'j','F22')<CR>gv
vnoremap <silent> <F18> :<C-U>call Focus('up',   'k','F23')<CR>gv
vnoremap <silent> <F19> :<C-U>call Focus('right','l','F24')<CR>gv
