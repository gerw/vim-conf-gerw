" Setting up the vim-indent-script

" Determine the script number
let g:IndentObjectNumber = substitute(maparg('ai','v'), '.*<SNR>\(\d*\).*', '\1', '')

" Delete the original mappings
vunmap ii
vunmap iI
vunmap ai
" vunmap aI
ounmap ii
ounmap iI
ounmap ai
ounmap aI

" Mappings excluding line below and line above.
exe "silent! onoremap <silent>ii :<C-u>cal <SNR>". g:IndentObjectNumber ."_HandleTextObjectMapping(1, 1, 0, [line(\".\"), line(\".\"), col(\".\"), col(\".\")])<CR>"
exe "silent! onoremap <silent>ai :<C-u>cal <SNR>". g:IndentObjectNumber ."_HandleTextObjectMapping(0, 1, 0, [line(\".\"), line(\".\"), col(\".\"), col(\".\")])<CR>"
exe "silent! vnoremap <silent>ii :<C-u>cal <SNR>". g:IndentObjectNumber ."_HandleTextObjectMapping(1, 1, 1, [line(\".\"), line(\".\"), col(\".\"), col(\".\")])<CR>"
exe "silent! vnoremap <silent>ai :<C-u>cal <SNR>". g:IndentObjectNumber ."_HandleTextObjectMapping(0, 1, 1, [line(\".\"), line(\".\"), col(\".\"), col(\".\")])<CR>"
