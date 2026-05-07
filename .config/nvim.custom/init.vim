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
Plug 'godlygeek/tabular'


"" Navigation
" fuzzy search
" Commands:
"   :Files [PATH]	Files (runs $FZF_DEFAULT_COMMAND if defined)
"   :GFiles [OPTS]	Git files (git ls-files)
"   :GFiles?	Git files (git status)
"   :Buffers	Open buffers
"   :Colors	Color schemes
"   :Ag [PATTERN]	ag search result (ALT-A to select all, ALT-D to deselect all)
"   :Rg [PATTERN]	rg search result (ALT-A to select all, ALT-D to deselect all)
"   :Lines [QUERY]	Lines in loaded buffers
"   :BLines [QUERY]	Lines in the current buffer
"   :Tags [QUERY]	Tags in the project (ctags -R)
"   :BTags [QUERY]	Tags in the current buffer
"   :Marks	Marks
"   :Windows	Windows
"   :Locate PATTERN	locate command output
"   :History	v:oldfiles and open buffers
"   :History:	Command history
"   :History/	Search history
"   :Snippets	Snippets (UltiSnips)
"   :Commits	Git commits (requires fugitive.vim)
"   :BCommits	Git commits for the current buffer; visual-select lines to track changes in the range
"   :Commands	Commands
"   :Maps	Normal mode mappings
"   :Helptags	Help tags 1
"   :Filetypes	File types
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" symbol list
Plug 'liuchengxu/vista.vim'
" jump to position where last time the file is edited
Plug 'farmergreg/vim-lastplace'


"" Looking
" theme
Plug 'NLKNguyen/papercolor-theme'
" beautiful tag bar on top
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" indention guide
" Plug 'Yggdroot/indentLine'
if has('nvim-0.5.0')
    Plug 'lukas-reineke/indent-blankline.nvim'
else
    Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'version-1'  }
endif
" pop-up window support
Plug 'Shougo/echodoc.vim'


"" Syntax Highlighting
" C++
Plug 'octol/vim-cpp-enhanced-highlight'
" Many languages
Plug 'sheerun/vim-polyglot'
" Powershell
Plug 'zigford/vim-powershell'
" nftables
Plug 'nfnty/vim-nftables'


"" Sementic
" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neoinclude.vim', { 'for': ['c', 'cpp'] }
Plug 'Shougo/deoplete-clangx', { 'for': ['c', 'cpp'] }
" Require: pip install jedi
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
" tags manager
" Plug 'ludovicchabant/vim-gutentags'
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
" GNU GLOBAL
let s:global_plugins = [
\  '/usr/share/vim/addons/plugin/gtags-cscope.vim',
\  '/usr/share/vim/addons/plugin/gtags.vim',
\  '/usr/local/opt/global/share/gtags/gtags-cscope.vim',
\  '/usr/local/opt/global/share/gtags/gtags.vim']
for plugin in s:global_plugins
    if filereadable(plugin)
        execute 'source ' . plugin
    endif
endfor


" Set project root
let g:asyncrun_root = getcwd()
if argc() > 0
    let p = fnamemodify(argv()[0], ':p')
    if isdirectory(p)
        let g:asyncrun_root = p
    endif
endif
