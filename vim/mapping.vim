let mapleader = ' '

" w : Save
" upper W is still words forward
" or e can be replacement
nnoremap w :w<CR>
vnoremap w <ESC>:w<CR>
" save and load config
autocmd FileType vim nmap <buffer> w :w \| source %<CR>
autocmd FileType vim vmap <buffer> w <ESC>:w \| source %<CR>


" Z : Close buffer
" q : Smart close window
" Q : Record macro
" gQ : Ex mode (originally Q)
" Notice: this masks ZZ and ZQ
" TODO: this will quit vim when only main window and tagbar window exists
"       even if there is other buffers
noremap <silent> q :call SmartClose()<CR>
noremap <leader>qq :q<CR>
noremap Z :bdelete<CR>
noremap Q q

" Inspired by: https://github.com/tpope/vim-unimpaired
" <Tab>: smart alternating file or switch window
" <leader><Tab>: alternating file
" DO NOT mistake tabs' use:
" http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
noremap <silent> <tab> :if winnr('$') == 1 \| b# \| else \| wincmd w \| endif<CR>
noremap <silent> <s-tab> :if winnr('$') == 1 \| b# \| else \| wincmd W \| endif<CR>
noremap <leader><tab> :b#<CR>
" Buffers
noremap [b :bprev<CR>
noremap ]b :bnext<CR>
" Location List
noremap <leader>lo :lopen<CR>
noremap <leader>lx :lclose<CR>
noremap [l :lprev<CR>
noremap ]l :lnext<CR>
" QuickFix
noremap <leader>qo :copen<CR>
noremap <leader>qx :cclose<CR>
noremap [q :cprev<CR>
noremap ]q :cnext<CR>
" tag match list
noremap [t :tprev<CR>
noremap ]t :tnext<CR>


" show bookmarks
noremap <leader>bm :marks<CR>

" 5/F5: [disabled] compile
" command is set in: after/compiler/xxx.vim
" autocmd FileType vim map <buffer> 5 :w \| source %<CR>
" map 5 :wa \| cclose \| copen \| wincmd p \| AsyncRun -cwd=$(VIM_ROOT) make<CR>
" blocking compilation:
" map <silent> 5 :wa \| silent! make \| cwindow \| wincmd p<CR>
" imap <F5> <ESC>5

" make / compile
" -save=2 : Save all files
" -program=make : Use &makeprg as :make (can be grep to use &grepprt)
" -cwd=<root> : Detected project root by AsyncRun
noremap <leader>m :AsyncRun -save=2 -cwd=<root> -program=make<CR>


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
" inspired by Sublime Text
nnoremap J :move +1<CR>
vnoremap J :'<,'>move '>+1\|normal gv<CR>
nnoremap K :move -2<CR>
vnoremap K :'<,'>move '<-2\|normal gv<CR>

" re-map join lines command
" note CTRL-j is same as j originally
noremap <C-j> J

" indent / unindent
" normal mode: indent a line
" visual mode: keep selection after indenting
noremap < <<_
noremap > >>_
vnoremap > >gv
vnoremap < <gv

" Enter / Return: create vertical space
" in help: jump to tag at current cursor
" note there shouldn't be space after noremap (before vertical bar)
autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd BufEnter * if &modifiable | nnoremap <CR> o<ESC>| endif

" Backspace: jump back
noremap <BS> <C-o>

" backquote ` (the key next to number 1): ESC
" to enter real ` : <C-v> + `
onoremap ` <ESC>
vnoremap ` <ESC>
inoremap ` <ESC>

" command line Home key
cnoremap <C-a> <Home>

" after replacing selection with p
" keep in register what is pasted rather than what is replaced
vnoremap p pgvy

" no highlight
noremap <leader>nh :noh<CR>

" alternate file (source / header)
" inspired by a.vim
noremap <leader>a :AlternateFile<CR>




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
" TODO: use Denite instead
" g:Lf_ShortcutF                                  *g:Lf_ShortcutF*
"     Use this option to set the mapping of searching files command.
"     e.g. let g:Lf_ShortcutF = '<C-P>'
"     Default value is '<leader>f'.
let g:Lf_ShortcutF = ''
" g:Lf_ShortcutB                                  *g:Lf_ShortcutB*
"     Use this option to set the mapping of searching buffers command.
"     Default value is '<leader>b'.
let g:Lf_ShortcutB = '<leader>fb'
" find (f)iles
" ^N stands for "now": open file in current working dir
noremap <silent> <leader>ff :execute ':Leaderf file --no-ignore ' . asyncrun#get_root('')<CR>
map <C-n> <leader>ff
" find functions, i.e. (s)ymbols
noremap <leader>fs :LeaderfFunction<CR>
" find most (r)ecently used
" ^P stands for "previous": open a file among previous edited ones
" and we use MRU as our startpoint
" note ^N is same as j originally
noremap <leader>fr :LeaderfMru<CR>
map <C-p> <leader>fr
" find (t)ags
noremap <leader>ft :LeaderfTag<CR>
" search in files by r(g)
" ^F is like "find in files" in modern editors
" Note: ^F scrolls a page down originally, this masks it
noremap <silent> <leader>fg :let g:Lf_WorkingDirectory = asyncrun#get_root('') \| Leaderf rg<CR>
map <C-f> <leader>fg


"""""""""""
" Airline "
"""""""""""
map <leader>1 <Plug>AirlineSelectTab1
map <leader>2 <Plug>AirlineSelectTab2
map <leader>3 <Plug>AirlineSelectTab3
map <leader>4 <Plug>AirlineSelectTab4
map <leader>5 <Plug>AirlineSelectTab5
map <leader>6 <Plug>AirlineSelectTab6
map <leader>7 <Plug>AirlineSelectTab7
map <leader>8 <Plug>AirlineSelectTab8
map <leader>9 <Plug>AirlineSelectTab9


""""""""""
" Denite "
""""""""""
" TODO: fuzzy search don't work
" find files recursively
" noremap <leader>ff :DeniteBufferDir file/rec<CR>
" " find recently used
" noremap <leader>fr :Denite file_mru<CR>
" " find tags
" noremap <leader>ft :Denite tag<CR>

" let s:insert_mode_mappings = [
"       \  ['jk', '<denite:enter_mode:normal>', 'noremap'],
"       \ ['<Tab>', '<denite:move_to_next_line>', 'noremap'],
"       \ ['<S-tab>', '<denite:move_to_previous_line>', 'noremap'],
"       \  ['<Esc>', '<denite:enter_mode:normal>', 'noremap'],
"       \  ['<C-N>', '<denite:assign_next_matched_text>', 'noremap'],
"       \  ['<C-P>', '<denite:assign_previous_matched_text>', 'noremap'],
"       \  ['<Up>', '<denite:assign_previous_text>', 'noremap'],
"       \  ['<Down>', '<denite:assign_next_text>', 'noremap'],
"       \  ['<C-Y>', '<denite:redraw>', 'noremap'],
"       \ ]
"
" let s:normal_mode_mappings = [
"       \   ["'", '<denite:toggle_select_down>', 'noremap'],
"       \   ['<C-n>', '<denite:jump_to_next_source>', 'noremap'],
"       \   ['<C-p>', '<denite:jump_to_previous_source>', 'noremap'],
"       \   ['gg', '<denite:move_to_first_line>', 'noremap'],
"       \   ['st', '<denite:do_action:tabopen>', 'noremap'],
"       \   ['sg', '<denite:do_action:vsplit>', 'noremap'],
"       \   ['sv', '<denite:do_action:split>', 'noremap'],
"       \   ['q', '<denite:quit>', 'noremap'],
"       \   ['r', '<denite:redraw>', 'noremap'],
"       \ ]
"
" for s:m in s:insert_mode_mappings
"   call denite#custom#map('insert', s:m[0], s:m[1], s:m[2])
" endfor
"
" for s:m in s:normal_mode_mappings
"   call denite#custom#map('normal', s:m[0], s:m[1], s:m[2])
" endfor



"""""""
" ALE "
"""""""
" noremap <leader>gd :ALEGoToDefinition<CR>
" noremap <leader>gt :ALEGoToTypeDefinition<CR>


"""""""""""""""""
" YouCompleteMe "
"""""""""""""""""
" noremap <leader>gt :YcmCompleter GetType<CR>
" " gh (get help)
" noremap <leader>gh :YcmCompleter GetDoc<CR>
" noremap <leader>gi :YcmCompleter GoToInclude<CR>
" noremap <leader>gd :YcmCompleter GoToDefinition<CR>


"""""""""""""""""
" vim-which-key "
"""""""""""""""""
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>


"""""""""""""
" incsearch "
"""""""""""""
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)
" let g:incsearch#auto_nohlsearch = 1
" map n  <Plug>(incsearch-nohl-n)
" map N  <Plug>(incsearch-nohl-N)
" map *  <Plug>(incsearch-nohl-*)
" map #  <Plug>(incsearch-nohl-#)
" map g* <Plug>(incsearch-nohl-g*)
" map g# <Plug>(incsearch-nohl-g#)
" map z/ <Plug>(incsearch-easymotion-/)
" map z? <Plug>(incsearch-easymotion-?)
" map zg/ <Plug>(incsearch-easymotion-stay)


""""""""""""""
" easymotion "
""""""""""""""
" move around
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
" 2-character search
nmap s <Plug>(easymotion-overwin-f2)
" n-character search
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
