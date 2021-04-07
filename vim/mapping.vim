let mapleader = ' '

" w : Save
" upper W is still words forward
" or e can be replacement
nnoremap w :<C-U>w<CR>
vnoremap w <ESC>:<C-U>w<CR>
" save and load config
autocmd FileType vim nnoremap <buffer> w :<C-U>w \| source %<CR>
autocmd FileType vim vnoremap <buffer> w <ESC>:<C-U>w \| source %<CR>


" Z or <leader>bd : Close buffer while keeping window (my plugin)
" q or <leader>qs : Smart quit (close buffer or window) (my plugin)
" Q : Record macro
" gQ : Ex mode (originally Q)
" Notice: this masks ZZ and ZQ
" TODO: this will quit vim when only main window and tagbar window exists
"       even if there is other buffers
noremap q :<C-U>SmartClose<CR>
noremap Z :<C-U>Bclose<CR>
noremap <leader>qs :<C-U>SmartClose<CR>
noremap <leader>qa :<C-U>qa<CR>
noremap <leader>bd :<C-U>Bclose<CR>
noremap Q q


" 0 : Alternate between 0 and ^ and # (my plugin)
" Don't map in operator-pending mode
nnoremap 0 :<C-U>Smart0<CR>
vnoremap 0 :<C-U>Smart0<CR>


" Switch between windows, buffers ...
" Inspired by: https://github.com/tpope/vim-unimpaired
"              https://github.com/SpaceVim/SpaceVim
" <Tab>: smart alternating file or switch window
" <leader><Tab>: alternating file
" DO NOT mistake tabs' use:
" http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
noremap <silent> <tab> :<C-U>if winnr('$') == 1 \| b# \| else \| wincmd w \| endif<CR>
noremap <silent> <s-tab> :<C-U>if winnr('$') == 1 \| b# \| else \| wincmd W \| endif<CR>
noremap <leader><tab> :<C-U>b#<CR>
" Buffers
noremap [b :<C-U>bprev<CR>
noremap ]b :<C-U>bnext<CR>
" Location List
noremap <leader>lo :<C-U>lopen<CR>
noremap <leader>lx :<C-U>lclose<CR>
noremap [l :<C-U>lprev<CR>
noremap ]l :<C-U>lnext<CR>
" QuickFix
noremap <leader>qo :<C-U>copen<CR>
noremap <leader>qx :<C-U>cclose<CR>
noremap [q :<C-U>cprev<CR>
noremap ]q :<C-U>cnext<CR>
" Tag match list
noremap [t :<C-U>tprev<CR>
noremap ]t :<C-U>tnext<CR>
" Jump list
noremap [j <C-O>
noremap ]j <C-I>


" Show bookmarks
noremap <leader>bm :<C-U>marks<CR>

" Make / Compile
" -save=2 : Save all files
" -program=make : Use &makeprg as when doing :make
"                 (or -program=grep to use &grepprt)
" -cwd=<root> : Detected project root by AsyncRun
noremap <leader>m :<C-U>AsyncRun -save=2 -cwd=<root> -program=make<CR>

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

" Move whole line(s) down/up
" Inspired by Sublime Text
nnoremap J :<C-U>move +1<CR>
vnoremap J :<C-U>'<,'>move '>+1\|normal gv<CR>
nnoremap K :<C-U>move -2<CR>
vnoremap K :<C-U>'<,'>move '<-2\|normal gv<CR>

" Re-map join lines command
" CTRL-j is same as j originally (move cursor downward)
noremap <C-j> J

" Indent / Unindent
" normal mode: [N]> will indent [N] lines, default N=1
" visual mode: keep selection after indenting
noremap < <_
noremap > >_
vnoremap > >gv
vnoremap < <gv

" Enter / Return: create vertical space
" in help: jump to tag at current cursor
" note there shouldn't be space after noremap (before vertical bar)
autocmd BufEnter *
            \  if &modifiable
            \|     nnoremap <buffer> <CR> o<ESC>
            \| elseif &filetype == 'help'
            \|     nnoremap <buffer> <CR> <C-]>
            \| endif

" Backspace: jump back
" noremap <BS> <C-o>

" Backquote ` (the key next to number 1): ESC
" to enter real ` : <C-v> + `
onoremap ` <ESC>
vnoremap ` <ESC>
inoremap ` <ESC>

" Command line Home key
cnoremap <C-a> <Home>

" After replacing selection with p, keep in register "" what is pasted
" rather than what is replaced
vnoremap p pgvy

" No highlight
noremap <leader>nh :<C-U>noh<CR>

" Alternate file (source / header)
" inspired by a.vim
noremap <leader>a :<C-U>AlternateFile<CR>

" Search
" Turn off highlight after cursor moves
" Inspired by: https://github.com/easymotion/vim-easymotion
"              https://github.com/justinmk/vim-sneak
" function! s:SmartHighlightAttachAutocmd()
"     " following code is from Easymotion#highlight#attach_autocmd()
"     augroup smart-highlight
"         autocmd!
"         autocmd InsertEnter,WinLeave,BufLeave <buffer>
"             \ silent! set nohlsearch
"             \  | autocmd! smart-highlight * <buffer>
"         autocmd CursorMoved <buffer>
"             \ autocmd smart-highlight CursorMoved <buffer>
"             \ silent! set nohlsearch
"             \  | autocmd! smart-highlight * <buffer>
"     augroup END
" endfunction
" noremap * :<C-U>set hlsearch \| call <SID>SmartHighlightAttachAutocmd()<CR>*
" noremap / :<C-U>set hlsearch \| call <SID>SmartHighlightAttachAutocmd()<CR>/
" noremap n :<C-U>set hlsearch \| call <SID>SmartHighlightAttachAutocmd()<CR>n
" noremap N :<C-U>set hlsearch \| call <SID>SmartHighlightAttachAutocmd()<CR>N

" Replace motion with recently yanked/deleted text
" Inspired by: https://github.com/inkarkat/vim-ReplaceWithRegister
" Masking out gr, which is seldom used
nnoremap <silent> gr :<C-U>set opfunc=<SID>ReplaceWithRegister<CR>g@
vnoremap <silent> gr :<C-U>call <SID>ReplaceWithRegister(visualmode(), 1)<CR>
map grr gr_
" following code is from manual of
function! s:ReplaceWithRegister(type, ...)
    let sel_save = &selection
    let reg_save = @@

    let &selection = "inclusive"

    if a:type  " Invoked from Visual mode, use gv command.
        silent exe "normal! gvpgvy"
    elseif a:type == 'line'
        silent exe "normal! '[V']pgvy"
    else
        silent exe "normal! `[v`]pgvy"
    endif

    let &selection = sel_save
    let @@ = reg_save
endfunction




"""""""""""""""""
" NERDCommenter "
"""""""""""""""""
" <C-_> means Ctrl + / in terminal
" but Ctrl + / is not recoginzed in gVim
" [N]<leader>/ for commenting N lines
map <leader>/ <Plug>NERDCommenterToggle


"""""""""""""""""""""
" Tagbar / NerdTree "
"""""""""""""""""""""
noremap <leader>tt :<C-U>TagbarToggle<CR>
noremap <leader>tn :<C-U>NerdTreeToggle<CR>


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
noremap <silent> <leader>ff :execute ':Leaderf file --no-ignore ' . asyncrun#get_root('%')<CR>
map <C-n> <leader>ff
" find functions, i.e. (s)ymbols
noremap <leader>fs :<C-U>LeaderfFunction<CR>
" find most (r)ecently used
" ^P stands for "previous": open a file among previous edited ones
" and we use MRU as our startpoint
" note ^N is same as j originally
noremap <leader>fr :<C-U>LeaderfMru<CR>
map <C-p> <leader>fr
" find (t)ags
noremap <leader>ft :<C-U>LeaderfTag<CR>
" search in files by r(g)
" ^F is like "find in files" in modern editors
" Note: ^F scrolls a page down originally, this masks it
noremap <silent> <leader>fg :<C-U>let g:Lf_WorkingDirectory = asyncrun#get_root('%') \| Leaderf rg<CR>
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
"       \  ['<ESC>', '<denite:enter_mode:normal>', 'noremap'],
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
nnoremap <silent> <leader> :<C-U>WhichKey '<Space>'<CR>


"""""""""""""
" NeoFormat "
"""""""""""""
" Format and then save
" nnoremap <leader>w :Neoformat \| w<CR>
" Just format
nnoremap <leader>fm :Neoformat<CR>


""""""""""""""
" easymotion "
""""""""""""""
" function! EasyMotion#S(num_strokes, visualmode, direction) " {{{
"   num_strokes:
"     The number of input characters. Currently provide 1, 2, or -1.
"     '-1' means no limit.
"   visualmode:
"     Vim script couldn't detect the function is called in visual mode by
"     mode(1), so tell whether it is in visual mode by argument explicitly
"   direction:
"     0 -> forward
"     1 -> backward
"     2 -> bi-direction (handle forward & backward at the same time) }}}
"
" function! EasyMotion#User(pattern, visualmode, direction, inclusive, ...) " {{{
"   inclusive:
"     usually 0
"     'f' motion is inclusive but 'F' motion is exclusive
"
" function! EasyMotion#OverwinF(num_strokes) " {{{
"   " no keeping last search pattern when <Plug>(easymotion-next) is invoked
"
" function! EasyMotion#NextPrevious(visualmode, direction) " {{{

" Move around
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)

" 2-character search, cross window
nmap <silent> s :<C-U>call EasyMotion#OverwinF(2)<CR>
omap <silent> s :<C-U>call EasyMotion#OverwinF(2)<CR>
vmap s <ESC>s

" N-character search
nmap <silent> / :<C-U>call EasyMotion#S(-1,0,2)<CR>
omap <silent> / :<C-U>call EasyMotion#S(-1,0,2)<CR>
vmap / <ESC>/

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

" Search the word under cursor
function! s:AddSearchHistory(re)
    " code is from Easymotion.s:findMotion()
    if g:EasyMotion_add_search_history
        let history_re = substitute(a:re, '\\c\|\\C', '', '')
        let @/ = history_re "For textobject: 'gn'
        call histadd('search', history_re)
    endif
endfunction
function! s:EasyMotionFindCursor()
    let re = '\<' . expand('<cword>') . '\>'
    call <SID>AddSearchHistory(re)
    call EasyMotion#User(re, 0, 2, 0)
    call EasyMotion#highlight#attach_autocmd()
    call EasyMotion#highlight#add_highlight(re, g:EasyMotion_hl_move)
endfunction
nmap <silent> * :<C-U>call <SID>EasyMotionFindCursor()<CR><ESC>
omap <silent> * :<C-U>call <SID>EasyMotionFindCursor()<CR><ESC>
vmap * <ESC>*

