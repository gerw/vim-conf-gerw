func! Focus(command, vim_command, key)

  let oldw = winnr()
  try
    silent exe 'wincmd ' . a:vim_command
  catch
  endtry
  let neww = winnr()
  if oldw == neww
    if hostname()=="sobolev" || hostname()=="kunigunde"
      silent noautocmd exe '!i3-msg -q focus ' . a:command
    else
      silent noautocmd exe '!xdotool key --delay 0 ' . a:key
    end

    if !has("gui_running")
        redraw!
    endif
  endif
  return ""
endfunction

" Focus!
nnoremap <silent> <F16>   :call Focus('left', 'h','F21')<CR>
nnoremap <silent> <F17>   :call Focus('down', 'j','F22')<CR>
nnoremap <silent> <F18>   :call Focus('up',   'k','F23')<CR>
nnoremap <silent> <F19>   :call Focus('right','l','F24')<CR>
nnoremap <silent> <M-F16> :call Focus('left', 'h','F21')<CR>
nnoremap <silent> <M-F17> :call Focus('down', 'j','F22')<CR>
nnoremap <silent> <M-F18> :call Focus('up',   'k','F23')<CR>
nnoremap <silent> <M-F19> :call Focus('right','l','F24')<CR>

inoremap <silent> <F16>   <C-O>:call Focus('left', 'h','F21')<CR>
inoremap <silent> <F17>   <C-O>:call Focus('down', 'j','F22')<CR>
inoremap <silent> <F18>   <C-O>:call Focus('up',   'k','F23')<CR>
inoremap <silent> <F19>   <C-O>:call Focus('right','l','F24')<CR>
inoremap <silent> <M-F16> <C-O>:call Focus('left', 'h','F21')<CR>
inoremap <silent> <M-F17> <C-O>:call Focus('down', 'j','F22')<CR>
inoremap <silent> <M-F18> <C-O>:call Focus('up',   'k','F23')<CR>
inoremap <silent> <M-F19> <C-O>:call Focus('right','l','F24')<CR>

vnoremap <silent> <F16>   :<C-U>call Focus('left', 'h','F21')<CR>gv
vnoremap <silent> <F17>   :<C-U>call Focus('down', 'j','F22')<CR>gv
vnoremap <silent> <F18>   :<C-U>call Focus('up',   'k','F23')<CR>gv
vnoremap <silent> <F19>   :<C-U>call Focus('right','l','F24')<CR>gv
vnoremap <silent> <M-F16> :<C-U>call Focus('left', 'h','F21')<CR>gv
vnoremap <silent> <M-F17> :<C-U>call Focus('down', 'j','F22')<CR>gv
vnoremap <silent> <M-F18> :<C-U>call Focus('up',   'k','F23')<CR>gv
vnoremap <silent> <M-F19> :<C-U>call Focus('right','l','F24')<CR>gv

cnoremap <silent> <F16>   <C-R>=Focus('left', 'h','F21')<CR>
cnoremap <silent> <F17>   <C-R>=Focus('down', 'j','F22')<CR>
cnoremap <silent> <F18>   <C-R>=Focus('up',   'k','F23')<CR>
cnoremap <silent> <F19>   <C-R>=Focus('right','l','F24')<CR>
cnoremap <silent> <M-F16> <C-R>=Focus('left', 'h','F21')<CR>
cnoremap <silent> <M-F17> <C-R>=Focus('down', 'j','F22')<CR>
cnoremap <silent> <M-F18> <C-R>=Focus('up',   'k','F23')<CR>
cnoremap <silent> <M-F19> <C-R>=Focus('right','l','F24')<CR>
