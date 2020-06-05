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
set colorcolumn=80

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

" Buffers
" allow buffer to be hidden without being saved
set hidden

" completion behaviour
set completeopt-=preview

set timeoutlen=500

let g:python_host_prog = trim(system('which python'))
let g:python3_host_prog = trim(system('which python3'))

" mouse
" set mouse=a
" set ttymouse=xterm

" DANGEROUS!!!
" load local .exrc for configuration
" set exrc


" QuickFix window specific options
" to use default behaviour when opening new buffer from a quickfix window
" we need to set it explicitly
" TODO: is there more elegant way?
autocmd BufWinEnter *
            \  if &filetype == 'qf'
            \|     set wrap nonumber foldcolumn=0
            \|     SignifyDisable
            \| else
            \|     set nowrap number foldcolumn=1
            \|     SignifyEnable
            \| endif
" autocmd QuickFixCmdPost * vertical botright copen 50

" error format for quickfix
autocmd FileType lua set errorformat=%[lua:\t]%#%f:%l:\ %m



packadd! termdebug

if has('win32')
    " Windows-specific commands
endif


" Startup
" start from choosing recent files
" TODO: this breaks syntax highlighting, fix it
" autocmd BufEnter * if argc() == 0 | LeaderfMru | endif
