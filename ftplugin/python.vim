" Mappings including line above.
exe "silent! onoremap <silent>ai :<C-u>cal <SNR>". g:IndentObjectNumber ."_HandleTextObjectMapping(0, 0, 0, [line(\".\"), line(\".\"), col(\".\"), col(\".\")])<CR>"
exe "silent! vnoremap <silent>ai :<C-u>cal <SNR>". g:IndentObjectNumber ."_HandleTextObjectMapping(0, 0, 1, [line(\".\"), line(\".\"), col(\".\"), col(\".\")])<CR>"
