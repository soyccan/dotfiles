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

set cscopetag

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
