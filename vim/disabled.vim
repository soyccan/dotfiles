"Plug 'vim-scripts/Conque-Shell'
"Plug 'tpope/vim-unimpaired'
" Plug 'Lokaltog/vim-powerline'
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'godlygeek/tabular'
" Plug 'jiangmiao/auto-pairs'
" Plug 'vim-scripts/STL-improved'

"" someone's vimrc:
"   UI related
"   Plug 'chriskempson/base16-vim'
"   Plug 'vim-airline/vim-airline'
"   Plug 'vim-airline/vim-airline-themes'
"   Better Visual Guide
"   Plug 'Yggdroot/indentLine'
"   syntax check
"   Plug 'w0rp/ale'
"   Autocomplete
"   Plug 'ncm2/ncm2'
"   Plug 'roxma/nvim-yarp'
"   Plug 'ncm2/ncm2-bufword'
"   Plug 'ncm2/ncm2-path'
"   Plug 'ncm2/ncm2-jedi'
"   Formater
"   Plug 'Chiel92/vim-autoformat'

"" syntax highlghtling
" agfline/c-syntax.vim
" octol/vim-cpp-enhanced-highlight
" bfrg/vim-cpp-modern

"" looking
Plug 'jacoborus/tender.vim'
Plug 'sickill/vim-monokai'
Plug 'dikiaap/minimalist'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jdkanani/vim-material-theme'
" syntax

"" editing
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all --clangd-completer' }
Plug 'Shougo/echodoc.vim'
Plug 'junegunn/vim-easy-align'
Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'
" integrate with auto formatter
" Plug 'Chiel92/vim-autoformat' " TODO: still not know how to use
" markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'lvht/tagbar-markdown', { 'for': 'markdown' }
Plug 'suan/vim-instant-markdown', { 'rtp': 'after', 'for': 'markdown' }
" additonal text object
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for': ['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'

"" navigating
" symbol list
Plug 'majutsushi/tagbar'
" browse files in project
Plug 'preservim/nerdtree'
" NerdTree Git support
Plug 'Xuyuanp/nerdtree-git-plugin'
" gtags: alternative of ctags and cscope
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
" fuzzy search function
Plug 'Yggdroot/LeaderF',  { 'do': './install.sh' }
" fuzzy search many things
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

"" others
Plug 'dbgx/lldb.nvim'
"Plug 'LucHermitte/lh-vim-lib'
"Plug 'LucHermitte/local_vimrc'
"
"
runtime pluginconf/vim-instant-markdown.vim
runtime pluginconf/vim-markdown.vim
runtime pluginconf/nerdcommenter.vim
runtime pluginconf/youcompleteme.vim
runtime pluginconf/denite.vim
runtime pluginconf/gutentags.vim
runtime pluginconf/vim-powerline.vim
runtime pluginconf/ale.vim
runtime pluginconf/leaderf.vim
runtime pluginconf/asyncrun.vim
runtime pluginconf/echodoc.vim
runtime pluginconf/indentline.vim
runtime pluginconf/airline.vim
runtime pluginconf/ultisnips.vim
runtime pluginconf/delimitMate.vim
runtime pluginconf/tagbar.vim
runtime pluginconf/nerdtree.vim
" runtime pluginconf/vim-autoformat.vim
" runtime pluginconf/auto-pairs.vim
" runtime pluginconf/nerdtree.vim
" runtime pluginconf/syntastic.vim
" runtime pluginconf/ctrlp.vim
" runtime options/gvim.vim
" runtime options/netrw.vim
