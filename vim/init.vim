" This config file is for NeoVim

"""""""""""
" Plugins "
"""""""""""
" Install Vim-Plug
let s:data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
let s:vimplug_dir = s:data_dir . '/autoload/plug.vim'
if empty(glob(s:vimplug_dir))
    silent execute '!curl -fLo ' . s:vimplug_dir .
          \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" TODO: replace vim-plug with dein
call plug#begin()

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
" align around any character
" select text and :EasyAlign N<char> or :EasyAlign N/<regex>/
Plug 'junegunn/vim-easy-align'


"" Navigation
" fuzzy search
" TODO: replace with denite
" in search box:
"   ctrl+j/k: up/down
"   ctrl+c: quit
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" fuzzy search with most-recently-used source
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neomru.vim'
" search in files
Plug 'mileszs/ack.vim'
" symbol list
Plug 'majutsushi/tagbar'
" fast motions
" jump to a search match by one single key
Plug 'easymotion/vim-easymotion'
" jump to position where last time the file is edited
Plug 'farmergreg/vim-lastplace'


"" Looking
" theme
Plug 'haishanh/night-owl.vim'
Plug 'joshdick/onedark.vim'
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
" Many languages
Plug 'sheerun/vim-polyglot'
" Powershell
Plug 'zigford/vim-powershell'


"" Sementic
" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neoinclude.vim', { 'for': ['c', 'cpp'] }
Plug 'Shougo/deoplete-clangx', { 'for': ['c', 'cpp'] }
" Require: pip install jedi
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
" Git wrapper
Plug 'tpope/vim-fugitive'
" highlight git difference
if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy'  }
endif
" async run shell commands, and project root detection
" set b:asyncrun_root to specify project root
Plug 'skywind3000/asyncrun.vim'
" :MarkdownPreview / :MarkdownPreviewStop
Plug 'iamcco/markdown-preview.nvim', {
            \ 'do': { -> mkdp#util#install()  },
            \ 'on': 'MarkDownPreview'  }

call plug#end()
" End Plugins


" Include other configurations
runtime mapping.vim
runtime options.vim
runtime looking.vim
runtime netrw.vim
for plugin in g:plugs_order
    execute 'runtime conf.d/' . plugin . '.vim'
endfor


" Set project root
let g:asyncrun_root = getcwd()
if argc() > 0
    let p = fnamemodify(argv()[0], ':p')
    if isdirectory(p)
        let g:asyncrun_root = p
    endif
endif
