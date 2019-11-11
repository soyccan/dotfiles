" TODO: add spaces around any operator
"
let mapleader = ' '

" switch buffers
" replaced by tab: gt / gT
"map <C-n> :bnext<CR>
"map <C-p> :bprevious<CR>

" list buffers
"map <F2> :ls<CR>
"imap <F2> <ESC><F2>

" F2
" save
map 2 :w<CR>
imap <F2> <ESC>2

" F3 and Tab
" tab; new / next / previous
map 3 :tabnew .<CR>
imap <F3> <ESC>3
noremap <Tab> gt
noremap <S-Tab> gT

" F4
" quit
map 4 :q<CR>
imap <F4> <ESC>4

" F5
" compile
" command is set in: after/compiler/xxx.vim
"
autocmd FileType vim map <buffer> 5 :w \| source %<CR>
autocmd FileType c   map <buffer> 5 :w \| cclose \| copen \| wincmd p \| AsyncRun gcc "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -Wall -Wextra -Wconversion -Dsoyccan -g -std=c11<CR>
autocmd FileType cpp map <buffer> 5 :w \| cclose \| copen \| wincmd p \| AsyncRun g++ "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -Wall -Wextra -Wconversion -Dsoyccan -g -std=c++17<CR>
map 5 :wa \| cclose \| copen \| wincmd p \| AsyncRun -cwd=$(VIM_ROOT) make<CR>
" blocking compilation:
" map <silent> 5 :wa \| silent! make \| cwindow \| wincmd p<CR>
imap <F5> <ESC>5

" F6
" run
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

" quickfix
" map <F7> :cc<CR>
" map <S-F7> :cp<CR>

" left down up right
noremap ; h
noremap q j
noremap j k
noremap k l

" move whole line down/up
nnoremap Q ddp
nnoremap J ddkP
" TODO: move of multiple lines doesn't work well
" vnoremap Q V:'<,'>m +2<CR>gv
" vnoremap J V:'<,'>m -2<CR>gv

" re-map join lines command
noremap <C-j> J

" indent / unindent while keeping selection
vnoremap > >gv
vnoremap < <gv

" Enter / Return
" create vertical space
" in help: jump to tag at current cursor
autocmd FileType help nnoremap <buffer> <Enter> <C-]>
autocmd FileType qf nnoremap <buffer> <Enter> <CR>
nnoremap <Enter> o<ESC>

" Backspace
" jump back
nnoremap <BS> <C-o>

" `
" move ESCAPE next to key 1
" to enter real ` : <C-v> + `
vnoremap ` <ESC>
inoremap ` <ESC>

" command line Home key
cnoremap <C-A> <Home>

" happy pasting
xnoremap p pgvy


" press 0 for HOME / (non-blank) HOME / END, alternatively
function! s:AlternateHomeEnd()
    " TODO; this function cause 'd0' to behave wrongly
    if col('.') == len(getline('.'))
        norm! 0
    elseif col('.') == 1 && (getline('.')[0] == ' ' || getline('.')[0] == '\t')
        norm! ^
    else
        norm! $
    endif
endfunction
" [DISABLED]
" map <silent> 0 :call <SID>AlternateHomeEnd()<CR>


""" Section: NERDCommenter
" <C-_> means Ctrl + / in terminal
" but Ctrl + / is not recoginzed in gVim
map <leader>/ <Plug>NERDCommenterToggle


""" Section: YouCompleteMe
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

""" Section: LeaderF
let g:Lf_ShortcutF = '<C-p>'
let g:Lf_ShortcutB = '<leader>fb'
noremap <leader>fm :LeaderfMru<CR>
noremap <leader>ff :LeaderfFunction<CR>
" noremap <leader>ff :LeaderfFunction!<CR>
" noremap <leader>fF :LeaderfFunction<CR>
noremap <leader>fb :LeaderfBuffer<CR>
noremap <leader>ft :LeaderfTag<CR>
