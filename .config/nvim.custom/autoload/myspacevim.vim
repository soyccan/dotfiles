function! myspacevim#before() abort
    call s:mappings()
    call s:options()
endfunction

function! s:options()
    set backspace=2
    set helplang=tw
    set hlsearch incsearch
    set ignorecase smartcase

    set cursorline
    set autoindent smartindent cindent
    set number
    set nowrap
    set ruler
    set scrolloff=5

    set noshowmode
    " set statusline+=%{gutentags#statusline()}

    set list
    set listchars=tab:┊\ ,trail:-,nbsp:+,extends:>,precedes:<

    set autochdir
    set autoread " auto reload when changed

    set nofoldenable
    set foldmethod=indent
    set foldcolumn=1
    set foldlevel=1

    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab " Ctrl-V + Tab to enter real tab

    " set cscopetag

    "" Buffers
    " allow buffer to be hidden without being saved
    set hidden

    " completion behaviour
    set completeopt-=preview

    " syntax
    let g:c_space_errors = 1
    let g:c_curly_error = 1
    let g:c_comment_strings = 1
    let g:is_bash = 1

    " mouse
    " set mouse=a
    " set ttymouse=xterm

    " DANGEROUS!!!
    " load local .exrc for configuration
    " set exrc


    " QuickFix window options
    autocmd FileType qf set wrap nonumber foldcolumn=0 | SignifyDisable
    " autocmd QuickFixCmdPost * vertical botright copen 50


    let g:python_host_prog = trim(system('which python'))
    let g:python3_host_prog = trim(system('which python3'))
endfunction

function! s:mappings()
    " w : Save
    " upper W is still words forward
    " or e can be replacement
    nnoremap w :w<CR>
    vnoremap w <ESC>:w<CR>
    " save and load config
    autocmd FileType vim nmap <buffer> w :w \| source %<CR>| vmap w :w \| source %<CR>

    " Z : Close buffer
    " Notice: this overrides ZZ and ZQ
    noremap Z :bdelete<CR>

    " move whole line(s) down/up
    nnoremap J ddp
    vnoremap <expr> J 'dp`[' . strgetchar(getregtype(), 0) . '`]'
    nnoremap K ddkP
    vnoremap <expr> K 'dkP`[' . strgetchar(getregtype(), 0) . '`]'

    " re-map join lines command
    noremap <C-j> J

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

    " after replacing selection with p
    " keep in register what is pasted rather than what is replaced
    vnoremap p pgvy
endfunction
