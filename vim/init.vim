""" This config file is for NeoVim
"
""" CHEATSHEET: UltiSnips
" let g:UltiSnipsExpandTrigger             = '<c-l>'
" let g:UltiSnipsListSnippets              = '<c-h>'
" let g:UltiSnipsJumpForwardTrigger        = '<c-j>'
" let g:UltiSnipsJumpBackwardTrigger       = '<c-k>'
"""
""" CHEATSHEET: surround
" csw) : change surround (nothing to change means add) - word - ()
" css{ : change surround (nothing to change means add) - sentence - {  }
" ysiw(: you surround - inner word - (  )
" cs"' : change surrond - " -> '
" dst  : delete surrond - <tag>
" in visual mode:
"     S{ : surrond with {
"""
""" CHEATSHEET: vim-gutentags
"   noremap <silent> <leader>cs :GscopeFind s <C-R><C-W><cr>
"   noremap <silent> <leader>cg :GscopeFind g <C-R><C-W><cr>
"   noremap <silent> <leader>cc :GscopeFind c <C-R><C-W><cr>
"   noremap <silent> <leader>ct :GscopeFind t <C-R><C-W><cr>
"   noremap <silent> <leader>ce :GscopeFind e <C-R><C-W><cr>
"   noremap <silent> <leader>cf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
"   noremap <silent> <leader>ci :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
"   noremap <silent> <leader>cd :GscopeFind d <C-R><C-W><cr>
"   noremap <silent> <leader>ca :GscopeFind a <C-R><C-W><cr>
"   0 or s: Find this symbol
"   1 or g: Find this definition
"   2 or d: Find functions called by this function
"   3 or c: Find functions calling this function
"   4 or t: Find this text string
"   6 or e: Find this egrep pattern
"   7 or f: Find this file
"   8 or i: Find files #including this file
"   9 or a: Find places where this symbol is assigned a value
" <leader>cg - 查看光标下符号的定义
" <leader>cs - 查看光标下符号的引用
" <leader>cc - 查看有哪些函数调用了该函数
" <leader>cf- 查找光标下的文件
" <leader>ci- 查找哪些文件 include 了本文件
" 查找到索引后跳到弹出的 quikfix 窗口，停留在想查看索引行上，按 小P直接打开预览窗口，大P关闭预览，\d 和 \u 向上向下滚动预览窗口。
"""
""" CHEATSHEET: extended text object
" i, 和 a, ：参数对象，写代码一半在修改，现在可以用 di, / ci, 一次性删除/改写当前参数
" ii 和 ai ：缩进对象，同一个缩进层次的代码，可以用 vii 选中，dii / cii 删除或改写
" if 和 af ：函数对象，可以用 vif / dif / cif 来选中/删除/改写函数的内容
"""
""" CHEATSHEET: LeaderF
" <ctrl-p>: 查找文件
" <leader>ff: 查找函数
" <tab> in LeaderF quick-fix window: toggle search bar
" <Ctrl-J>, 向下, <Ctrl-K>, 向上
" <Ctrl-X> : open in horizontal split window.
" <Ctrl-]> : open in vertical split window.
" <Ctrl-T> : open in new tabpage.
"""
""" CHEATSHEET: vim-plug
""" Commands
" PlugInstall [name ...] [#threads]	Install plugins
" PlugUpdate [name ...] [#threads]	Install or update plugins
" PlugClean[!]	Remove unlisted plugins (bang version will clean without prompt)
" PlugUpgrade	Upgrade vim-plug itself
" PlugStatus	Check the status of plugins
" PlugDiff	Examine changes from the previous update and the pending changes
" PlugSnapshot[!] [output path]	Generate script for restoring the current snapshot of the plugins
"
"" Plug options
" Option	Description
" branch/tag/commit	Branch/tag/commit of the repository to use
" rtp	Subdirectory that contains Vim plugin
" dir	Custom directory for the plugin
" as	Use different name for the plugin
" do	Post-update hook (string or funcref)
" on	On-demand loading: Commands or <Plug>-mappings
" for	On-demand loading: File types
" frozen	Do not update unless explicitly specified
"
"" Global options
" Flag	Default	Description
" g:plug_threads	16	Default number of threads to use
" g:plug_timeout	60	Time limit of each task in seconds (Ruby & Python)
" g:plug_retries	2	Number of retries in case of timeout (Ruby & Python)
" g:plug_shallow	1	Use shallow clone
" g:plug_window	vertical topleft new	Command to open plug window
" g:plug_pwindow	above 12new	Command to open preview window in PlugDiff
" g:plug_url_format	https://git::@github.com/%s.git	printf format to build repo URL (Only applies to the subsequent Plug commands)
"
"" Keybindings
" D - PlugDiff
" S - PlugStatus
" R - Retry failed update or installation tasks
" U - Update plugins in the selected range
" q - Close the window
" :PlugStatus
" L - Load plugin
" :PlugDiff
" X - Revert the update
"
""" END CHEATSHEETS



""" vim-plug
""" init
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$HOME/.local/share/nvim/plugged')

if has('win32')
    " Windows-specific commands
endif

""" Plugins
"" disabled
"Plug 'vim-scripts/Conque-Shell'
"Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
"Plug 'tpope/vim-unimpaired'
" Plug 'Lokaltog/vim-powerline'
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'godlygeek/tabular'
" Plug 'jiangmiao/auto-pairs'
" denite: alternative of CtrlP
" Plug 'Shougo/denite.nvim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'
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
Plug 'octol/vim-cpp-enhanced-highlight'
" agfline/c-syntax.vim
" octol/vim-cpp-enhanced-highlight
" bfrg/vim-cpp-modern

"" looking
Plug 'sickill/vim-monokai'
Plug 'dikiaap/minimalist'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jdkanani/vim-material-theme'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
" vim-signify: alternative of gitgutter
Plug 'mhinz/vim-signify'
" syntax
Plug 'chr4/nginx.vim'

"" editing
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --clangd-completer --go-completer --ts-completer --rust-completer' }
Plug 'Shougo/echodoc.vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'
" ALE: alternative of Syntastic
Plug 'dense-analysis/ale'
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
" gtags: alternative of ctags and cscope
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
" fuzzy search function, alternative of tagbar
Plug 'Yggdroot/LeaderF',  { 'do': './install.sh' }

"" others
Plug 'skywind3000/asyncrun.vim'
"Plug 'LucHermitte/lh-vim-lib'
"Plug 'LucHermitte/local_vimrc'

call plug#end()

""" end vim-plug

packadd! termdebug
" runtime compilers.vim
" runtime cscope_maps.vim
runtime mapping.vim
runtime options.vim
runtime looking.vim
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
" runtime pluginconf/auto-pairs.vim
" runtime pluginconf/nerdtree.vim
" runtime pluginconf/tagbar.vim
" runtime pluginconf/syntastic.vim
" runtime pluginconf/ctrlp.vim
" runtime options/gvim.vim
" runtime options/netrw.vim
