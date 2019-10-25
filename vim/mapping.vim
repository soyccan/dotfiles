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
autocmd FileType vim map <buffer> 5 :w<CR>:source %<CR>
autocmd FileType c   map <buffer> 5 :w<CR>:AsyncRun gcc "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -std=c11 -Wall -Wextra -Dsoyccan -g<CR>
autocmd FileType cpp map <buffer> 5 :w<CR>:AsyncRun g++ "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -std=c++17 -Wall -Wextra -Dsoyccan -g<CR>
map 5 :wa<CR>:AsyncRun -cwd=$(VIM_ROOT) make<CR>
imap <F5> <ESC>5

" F6
" run
autocmd FileType vim    map <buffer> 6 :w<CR>:source %<CR>
autocmd FileType python map <buffer> 6 :w<CR>:AsyncRun python "$(VIM_FILEPATH)"<CR>
autocmd FileType ruby   map <buffer> 6 :w<CR>:AsyncRun ruby "$(VIM_FILEPATH)"<CR>
autocmd FileType sh     map <buffer> 6 :w<CR>:AsyncRun "$(VIM_FILEPATH)"<CR>
map 6 :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<CR>
imap <F6> <ESC>6

" F7
" compile && run
map 7 56
imap <F7> <ESC>7

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
vnoremap Q V:'<,'>m +2<CR>gv
nnoremap J ddkP
vnoremap J V:'<,'>m -2<CR>gv

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
