" let g:netrw_hide = 1

" tree view
let g:netrw_liststyle = 3

" let g:netrw_banner = 0
" let g:netrw_browse_split = 4
" let g:netrw_winsize = 25
" let g:netrw_altv = 1
" let g:netrw_chgwin = 2
" let g:netrw_list_hide = '.*\.swp$'
" let g:netrw_localrmdir = 'rm -rf'

" inspired by: http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
" augroup SplitExplorer
"     autocmd!
"     autocmd WinEnter * if argc() == 0 | Explore! | endif
"     autocmd TabNew * if argc() == 0 | Explore! | endif
" augroup END

" augroup ProjectDrawer
"     autocmd!
"     autocmd VimEnter * :Vexplore
"     autocmd VimEnter * :wincmd p
" augroup END
" let g:DirTreeOn = 0
" function! s:ToggleDirTree()
"     if (g:DirTreeOn == 1)
"         let g:DirTreeOn = 0
"         :wincmd t
"         :q
"     else
"         let g:DirTreeOn = 1
"         :Vexplore
"         :wincmd p
"     endif
" endfunction
