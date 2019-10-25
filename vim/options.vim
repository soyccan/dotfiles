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
set listchars=tab:┊\ ,nbsp:-,extends:>,precedes:<

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

" set tags=./.tags;,.tags
set cscopetag

" syntax
let g:c_space_errors = 1
let g:c_curly_error = 1
let g:c_comment_strings = 1

" DANGEROUS!!!
" load local .exrc for configuration
" set exrc
