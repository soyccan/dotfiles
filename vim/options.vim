set backspace=indent,eol,start
set helplang=tw
set hlsearch incsearch
set ignorecase smartcase

if has('nvim')
    " Shows the effects of a command incrementally, as you type
    " Works for |:substitute|, |:smagic|, |:snomagic|. |hl-Substitute|
    set inccommand=nosplit
endif

set cursorline
set number
set nowrap
set ruler
set scrolloff=5
set colorcolumn=80
set noshowmode

set nofoldenable
set foldmethod=indent
set foldcolumn=1
set foldlevel=1

set list
set listchars=tab:┊\ ,trail:-,nbsp:+,extends:>,precedes:<

filetype plugin indent on
syntax on

" &cindent and &cinoptions is ignored if &indentexpr is set
" Many languages other than C have defined their indent convension
" in $VIM/runtime/indent
" &autoindent, &smartindent and &cindent aren't necessary if filetype-based
" indent is enabled by exeuting "filetype indent on"
"
" set autoindent
" set smartindent
" set cindent
"
" align with parentheses
set cinoptions+=(0

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab " use space instead of tab; Ctrl-V + Tab to enter real tab
set nofixendofline " no LF at file end
set virtualedit=block " virtual edit in Visual-block mode

" When this option is on some plugins may not work
" set autochdir

set autoread " auto reload when changed

" GNU GLOBAL: a source code tag system
" global installs plugins:
"   /usr/share/vim/addons/plugin/gtags-cscope.vim
"   /usr/share/vim/addons/plugin/gtags.vim
" we don't use ctags but gtags, which is of cscope-like interface
" (gtags-cscope)
" Update: NeoVim 0.9 removed Cscope support
" set cscopetag
" set cscopeprg=gtags-cscope
" let GtagsCscope_Auto_Load = 1
" let GtagsCscope_Auto_Map = 1

" Buffers
" allow buffer to be hidden without being saved
set hidden

" Completion behaviour
set completeopt-=preview

set timeoutlen=500

" Ignore white space difference in diff mode
set diffopt-=internal
set diffopt+=iwhiteall

" default updatetime 4000ms is not good for async update
set updatetime=100

for name in ['python3', 'python']
    if !exists('g:python_host_prog')
        let g:python_host_prog = trim(exepath(name))
    endif

    if !exists('g:python3_host_prog')
        let g:python3_host_prog = trim(exepath(name))
    endif
endfor


" set syntax=sh default to posix
" see: $VIM/runtime/syntax/sh.vim
let g:is_bash = 1
" let g:is_posix = 1

" Clipboard for mac
" This breaks block-mode paste
set clipboard=unnamed

" Mouse
set mouse=a
" set ttymouse=xterm

" DANGEROUS!!!
" load local .exrc for configuration
" set exrc


" Close Netrw buffer when it loses focus
autocmd FileType netrw setl bufhidden=wipe

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

" fix the problem that quickfix will open inside tagbar
autocmd filetype qf wincmd J

" error format for quickfix
autocmd FileType lua set errorformat=%[lua:\t]%#%f:%l:\ %m

" Trim trailing whitespace
autocmd BufWritePre * %s/\s\+$//ge

packadd! termdebug

if has('win32')
    " Windows-specific commands
endif

" Startup
" start from choosing recent files
" TODO: this breaks syntax highlighting, fix it
" autocmd BufEnter * if argc() == 0 | LeaderfMru | endif

" restore buffers
" set viminfo^=%
