let mapleader = ' '

" w : Save
" upper W is still words forward
" or e can be replacement
nnoremap w :w<CR>
vnoremap w <ESC>:w<CR>
" save and load config
autocmd FileType vim nmap <buffer> w :w \| source %<CR>| vmap w :w \| source %<CR>

" Z : Close buffer
" Q : Close window
" gQ is still entering Ex mode
" Notice: this overrides ZZ and ZQ
noremap Z :bdelete<CR>
noremap Q :q<CR>

" <Tab>/<S-Tab>: Switch buffer
" DO NOT mistake tabs' use:
" http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
noremap <Tab> :bnext<CR>
noremap <S-Tab> :bprev<CR>

" 5/F5: [disabled] compile
" command is set in: after/compiler/xxx.vim
" autocmd FileType vim map <buffer> 5 :w \| source %<CR>
" map 5 :wa \| cclose \| copen \| wincmd p \| AsyncRun -cwd=$(VIM_ROOT) make<CR>
" blocking compilation:
" map <silent> 5 :wa \| silent! make \| cwindow \| wincmd p<CR>
" imap <F5> <ESC>5

" 6/F6: [disabled] run
" autocmd FileType vim    map <buffer> 6 :w<CR>:source %<CR>
" autocmd FileType python map <buffer> 6 :w<CR>:cclose \| vertical botright copen 50 \| wincmd p \| AsyncRun -raw python "$(VIM_FILEPATH)"<CR>
" autocmd FileType ruby   map <buffer> 6 :w<CR>:cclose \| vertical botright copen 50 \| wincmd p \| AsyncRun -raw ruby   "$(VIM_FILEPATH)"<CR>
" autocmd FileType sh     map <buffer> 6 :w<CR>:cclose \| vertical botright copen 50 \| wincmd p \| AsyncRun -raw sh     "$(VIM_FILEPATH)"<CR>
" map 6 :cclose \| vertical botright copen 50 \| wincmd p \| AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<CR>
" blocking run:
" map <silent> 6 :cexpr system(shellescape(expand("%:p:r"))) \| vertical botright copen 50 \| wincmd p<CR>
" imap <F6> <ESC>6

" F7
" compile && run
" TODO: make it work well with AsyncRun
" map 7 56
" imap <F7> <ESC>7

" move whole line(s) down/up
nnoremap J ddp
vnoremap <expr> J 'dp`[' . strgetchar(getregtype(), 0) . '`]'
nnoremap K ddkP
vnoremap <expr> K 'dkP`[' . strgetchar(getregtype(), 0) . '`]'
" TODO: move of multiple lines doesn't work well
" vnoremap Q V:'<,'>m +2<CR>gv
" vnoremap J V:'<,'>m -2<CR>gv

" re-map join lines command
noremap <C-j> J

" indent / unindent while keeping selection
vnoremap > >gv
vnoremap < <gv

" Enter / Return: create vertical space
" in help: jump to tag at current cursor
autocmd FileType help nnoremap <buffer> <Enter> <C-]>
autocmd FileType qf nnoremap <buffer> <Enter> <CR>
nnoremap <Enter> o<ESC>

" Backspace: jump back
noremap <BS> <C-o>

" backquote ` (the key next to number 1): ESC
" to enter real ` : <C-v> + `
onoremap ` <ESC>
vnoremap ` <ESC>
inoremap ` <ESC>

" command line Home key
cnoremap <C-A> <Home>

" after replacing selection with p
" keep in register what is pasted rather than what is replaced
vnoremap p pgvy


" [DISABLED] press 0 for HOME / (non-blank) HOME / END, alternatively
" function! s:AlternateHomeEnd()
"     " TODO; this function cause 'd0' to behave wrongly
"     if col('.') == len(getline('.'))
"         norm! 0
"     elseif col('.') == 1 && (getline('.')[0] == ' ' || getline('.')[0] == '\t')
"         norm! ^
"     else
"         norm! $
"     endif
" endfunction
" map <silent> 0 :call <SID>AlternateHomeEnd()<CR>


"""""""""""""""""""""
" <leader> mappings "
"""""""""""""""""""""
" make / compile
noremap <leader>m :wa \| AsyncRun -cwd=$(VIM_ROOT) make<CR>

" Location List
noremap <leader>lo :lopen<CR>
noremap <leader>lx :lclose<CR>
noremap <leader>ln :lnext<CR>
noremap <leader>lp :lprev<CR>
" QuickFix
noremap <leader>qo :copen<CR>
noremap <leader>qx :cclose<CR>
noremap <leader>qn :cnext<CR>
noremap <leader>qp :cprev<CR>

" show bookmarks
noremap <leader>bm :marks<CR>


"""""""""""""""""
" NERDCommenter "
"""""""""""""""""
" <C-_> means Ctrl + / in terminal
" but Ctrl + / is not recoginzed in gVim
map <leader>/ <Plug>NERDCommenterToggle


"""""""""""""""""""""
" Tagbar / NerdTree "
"""""""""""""""""""""
noremap <leader>tt :TagbarToggle<CR>
noremap <leader>tn :NerdTreeToggle<CR>


"""""""""""
" LeaderF "
"""""""""""
" g:Lf_ShortcutF                                  *g:Lf_ShortcutF*
"     Use this option to set the mapping of searching files command.
"     e.g. let g:Lf_ShortcutF = '<C-P>'
"     Default value is '<leader>f'.
let g:Lf_ShortcutF = '<leader>ff'
" g:Lf_ShortcutB                                  *g:Lf_ShortcutB*
"     Use this option to set the mapping of searching buffers command.
"     Default value is '<leader>b'.
let g:Lf_ShortcutB = '<leader>fb'
" find functions (symbols)
noremap <leader>fs :LeaderfFunction<CR>
" find recently used
noremap <leader>fr :LeaderfMru<CR>
" find tags
noremap <leader>ft :LeaderfTag<CR>


"""""""
" ALE "
"""""""
" noremap <leader>gd :ALEGoToDefinition<CR>
" noremap <leader>gt :ALEGoToTypeDefinition<CR>


"""""""""""""""""
" YouCompleteMe "
"""""""""""""""""
noremap <leader>gt :YcmCompleter GetType<CR>
" gh (get help)
noremap <leader>gh :YcmCompleter GetDoc<CR>
noremap <leader>gi :YcmCompleter GoToInclude<CR>
noremap <leader>gd :YcmCompleter GoToDefinition<CR>
