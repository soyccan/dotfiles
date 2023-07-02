function s:FormatBuffer()
  if &modified && executable('clang-format')
    " && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction
" autocmd BufWrite *.c,*.cpp,*.h call <SID>FormatBuffer()
