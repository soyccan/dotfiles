let mapleader = ' '

" 2/F2: save
map 2 :w<CR>
imap <F2> <ESC>2

" 3/F3: new tab
" <Tab>/<S-Tab>: switch tab
map 3 :tabnew .<CR>
imap <F3> <ESC>3
noremap <Tab> gt
noremap <S-Tab> gT

" 4/F4: quit
map 4 :q<CR>
imap <F4> <ESC>4

" 5/F5: compile
" command is set in: after/compiler/xxx.vim
autocmd FileType vim map <buffer> 5 :w \| source %<CR>
map 5 :wa \| cclose \| copen \| wincmd p \| AsyncRun -cwd=$(VIM_ROOT) make<CR>
" blocking compilation:
" map <silent> 5 :wa \| silent! make \| cwindow \| wincmd p<CR>
imap <F5> <ESC>5

" 6/F6: run
autocmd FileType vim    map <buffer> 6 :w<CR>:source %<CR>
autocmd FileType python map <buffer> 6 :w<CR>:cclose \| vertical botright copen 50 \| wincmd p \| AsyncRun -raw python "$(VIM_FILEPATH)"<CR>
autocmd FileType ruby   map <buffer> 6 :w<CR>:cclose \| vertical botright copen 50 \| wincmd p \| AsyncRun -raw ruby   "$(VIM_FILEPATH)"<CR>
autocmd FileType sh     map <buffer> 6 :w<CR>:cclose \| vertical botright copen 50 \| wincmd p \| AsyncRun -raw sh     "$(VIM_FILEPATH)"<CR>
map 6 :cclose \| vertical botright copen 50 \| wincmd p \| AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<CR>
" blocking run:
" map <silent> 6 :cexpr system(shellescape(expand("%:p:r"))) \| vertical botright copen 50 \| wincmd p<CR>
imap <F6> <ESC>6

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
map <leader>m :marks<CR>


"""""""""""""""""
" NERDCommenter "
"""""""""""""""""
" <C-_> means Ctrl + / in terminal
" but Ctrl + / is not recoginzed in gVim
map <leader>/ <Plug>NERDCommenterToggle


""""""""""
" Tagbar "
""""""""""
map <leader>t :TagbarToggle<CR>


""" Section: YouCompleteMe
" nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>


""" Section: LeaderF
" let g:Lf_ShortcutF = '<C-p>'
" let g:Lf_ShortcutB = '<leader>fb'
" " find recent
" noremap <leader>fr :LeaderfMru<CR>
" " find function
" noremap <leader>ff :LeaderfFunction<CR>
" " find buffer
" noremap <leader>fb :LeaderfBuffer<CR>
" " find tag
" noremap <leader>ft :LeaderfTag<CR>
