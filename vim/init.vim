" This config file is for NeoVim

"""""""""""
" Plugins "
"""""""""""
call plug#begin(stdpath('data') . '/plugged')

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
" <count>ai 	An Indentation level and line above.
" <count>ii 	Inner Indentation level (no line above).
Plug 'michaeljsmith/vim-indent-object'


"" Navigation
" symbol list
Plug 'majutsushi/tagbar'
" fuzzy search
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }


"" Looking
" theme
Plug 'jacoborus/tender.vim'
" beautiful tag bar on top
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" indention guide
Plug 'Yggdroot/indentLine'


"" Syntax Highlighting
" C++
Plug 'octol/vim-cpp-enhanced-highlight'
" Nginx config
Plug 'chr4/nginx.vim'


"" Syntax Checking
" async syntax checking, auto formatting
" (ALE's completion feature is disabled)
Plug 'dense-analysis/ale'


"" Completion
" completion engine
" TODO: how about YouCompleteMe?
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
if !has('nvim')
    " additional plugin for deoplete
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
" C/C++ source for deoplite
Plug 'Shougo/deoplete-clangx', { 'for': ['c', 'cpp'] }
" Python source for deoplite
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }


"" Others
" highlight git difference
Plug 'mhinz/vim-signify'
" async run shell commands
Plug 'skywind3000/asyncrun.vim'

call plug#end()



""""""""""""""""""""
" Config Inclusion "
""""""""""""""""""""
runtime mapping.vim
runtime options.vim
runtime looking.vim
runtime filetype.vim
runtime pluginconf/nerdcommenter.vim
runtime pluginconf/vim-signify.vim
runtime pluginconf/vim-airline.vim
runtime pluginconf/indentLine.vim
runtime pluginconf/ale.vim
runtime pluginconf/deoplete.vim
runtime pluginconf/delimitMate.vim
runtime pluginconf/leaderf.vim



""""""""""
" Others "
""""""""""
packadd! termdebug

if has('win32')
    " Windows-specific commands
endif
