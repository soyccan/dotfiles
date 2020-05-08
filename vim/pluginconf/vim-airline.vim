let g:airline_theme='dark_minimal'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" Smarter tab line
" Automatically displays all buffers when there's only one tab open.
" This is disabled by default; add the following to your vimrc to enable the extension:
let g:airline#extensions#tabline#enabled = 1

" Separators can be configured independently for the tabline, so here is how you can define "straight" tabs:
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'

" In addition, you can also choose which path formatter airline uses. This
" affects how file paths are displayed in each individual tab as well as the
" current buffer indicator in the upper right. To do so, set the formatter
" field with:
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
