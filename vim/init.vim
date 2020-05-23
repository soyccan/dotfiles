" This config file is for NeoVim

"""""""""""
" Plugins "
"""""""""""
" TODO: replace vim-plug with dein
call plug#begin(stdpath('data') . '/plugged')

" required plugin for Vim8
if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

"" Editing
" <leader>/ for toggling comment
" <leader>cc for commenting
" <leader>cu for uncommenting
Plug 'preservim/nerdcommenter'
" in visual mode, Sx for surrounding selection with character x
" left ( will add extra space while right ) will not
Plug 'tpope/vim-surround'
" auto finish bracket pair
Plug 'Raimondi/delimitMate'
" Defines a new text object representing lines of code at the same indent level.
" Useful for python/vim scripts
" <count>ai     An Indentation level and line above.
" <count>ii     Inner Indentation level (no line above).
Plug 'michaeljsmith/vim-indent-object'
" linter / checker
Plug 'neomake/neomake'
" formatter
Plug 'sbdchd/neoformat'


"" Navigation
" fuzzy search
" TODO: replace with denite
" in search box:
"   ctrl+j/k: up/down
"   ctrl+c: quit
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" fuzzy search with most-recently-used source
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neomru.vim'
" search in files
Plug 'mileszs/ack.vim'
" symbol list
Plug 'majutsushi/tagbar'


"" Looking
" theme
Plug 'jacoborus/tender.vim'
" beautiful tag bar on top
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" indention guide
Plug 'Yggdroot/indentLine'
" pop-up window support
Plug 'Shougo/echodoc.vim'


"" Syntax Highlighting
" C++
Plug 'octol/vim-cpp-enhanced-highlight'
" Nginx config
Plug 'chr4/nginx.vim'


"" Sementic
" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" C/C++ source for deoplite
Plug 'Shougo/deoplete-clangx', { 'for': ['c', 'cpp'] }
" Python source for deoplite
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
"
" TODO: YouCompleteMe vs. deoplete
" Completion / go-to-definition
" Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }
" tags manager
Plug 'ludovicchabant/vim-gutentags'
" auto connect cscope database and define :GscopeFind command
" Plug 'skywind3000/gutentags_plus', { 'for': ['c', 'cpp'] }


"" Others
" key mapping cheatsheet
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" locate project root
Plug 'dbakker/vim-projectroot'
" highlight git difference
Plug 'mhinz/vim-signify'
" async run shell commands
Plug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }
" :MarkdownPreview / :MarkdownPreviewStop
Plug 'iamcco/markdown-preview.nvim', {
            \ 'do': { -> mkdp#util#install()  },
            \ 'on': 'MarkDownPreview'  }

call plug#end()



""""""""""""""""""""
" Config Inclusion "
""""""""""""""""""""
runtime mapping.vim
runtime options.vim
runtime looking.vim
for plugin in g:plugs_order
    " if !filereadable(expand('~/.config/nvim/conf.d/'.plugin.'.vim'))
    "     echo plugin
    " end
    execute 'runtime conf.d/' . plugin . '.vim'
endfor



""""""""""
" Others "
""""""""""
packadd! termdebug

if has('win32')
    " Windows-specific commands
endif
