let mapleader = ' '

" w : Save
" upper W is still words forward
" or e can be replacement
nmap w :w<CR>
vmap w :w<CR>
" save and load config
autocmd FileType vim nmap w :w \| source %<CR>| vmap w :w \| source %<CR>

" Z : Close buffer
" Q : Close window
" gQ is still entering Ex mode
" Notice: this overrides ZZ and ZQ
map Z :bdelete<CR>
map Q :q<CR>

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

" move whole line down/up
nnoremap J ddp
nnoremap K ddkP
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
nnoremap <BS> <C-o>

" backquote ` (the key next to number 1): ESC
" to enter real ` : <C-v> + `
vnoremap ` <ESC>
inoremap ` <ESC>

" command line Home key
cnoremap <C-A> <Home>

" paste again and again and again...
xnoremap p pgvy


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



""""""""""""""""""""""""""""
" Location List / QuickFix "
""""""""""""""""""""""""""""
map <leader>lo :lopen<CR>
map <leader>lx :lclose<CR>
map <leader>ln :lnext<CR>
map <leader>lp :lprev<CR>

map <leader>co :copen<CR>
map <leader>cx :cclose<CR>
map <leader>cn :cnext<CR>
map <leader>cp :cprev<CR>


"""""""""""""
" Bookmarks "
"""""""""""""
" show bookmarks
map <leader>m :marks<CR>


"""""""""""""""""
" NERDCommenter "
"""""""""""""""""
" <C-_> means Ctrl + / in terminal
" but Ctrl + / is not recoginzed in gVim
map <leader>/ <Plug>NERDCommenterToggle


"""""""""""""""""""""
" Tagbar / NerdTree "
"""""""""""""""""""""
map <leader>tt :TagbarToggle<CR>
map <leader>tn :NerdTreeToggle<CR>


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


""" Section: YouCompleteMe
" nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
