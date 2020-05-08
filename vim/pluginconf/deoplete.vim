" # deoplete.nvim
"
" > Dark powered asynchronous completion framework for neovim/Vim8
"
" [![Build Status](https://travis-ci.org/Shougo/deoplete.nvim.svg?branch=master)](https://travis-ci.org/Shougo/deoplete.nvim)
" [![Join the chat at https://gitter.im/Shougo/deoplete.nvim](https://badges.gitter.im/Shougo/deoplete.nvim.svg)](https://gitter.im/Shougo/deoplete.nvim?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
" [![Doc](https://img.shields.io/badge/doc-%3Ah%20deoplete-orange.svg)](doc/deoplete.txt)
"
" Deoplete is the abbreviation of "dark powered neo-completion".  It
" provides an extensible and asynchronous completion framework for
" neovim/Vim8.
"
" deoplete will display completions via `complete()` by default.
"
" Here are some [completion sources](https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources) specifically made for deoplete.nvim.
"
" <!-- vim-markdown-toc GFM -->
"
" - [Install](#install)
"   - [Requirements](#requirements)
" - [Configuration](#configuration)
" - [Screenshots](#screenshots)
"
" <!-- vim-markdown-toc -->
"
" ## Configuration
"
" ```vim
" " Use deoplete.
let g:deoplete#enable_at_startup = 1
" ```
"
" See `:help deoplete-options` for a complete list of options.
"

"""""""""""""""""""
" deoplete-clangx "
"""""""""""""""""""
" # C/C++ Completion for deoplete using clang
"
"
" ## Install
"
" * Install the latest deoplete.nvim
" * Make sure you already have clang(`clang` command)
"
"
" ## Customization
"
" ```vim
" " Change clang binary path
call deoplete#custom#var('clangx', 'clang_binary', trim(system('which clang')))
"
" " Change clang options
call deoplete#custom#var('clangx', 'default_c_options', '')
call deoplete#custom#var('clangx', 'default_cpp_options', '')
" ```
"
"
" ### neoinclude
"
" deoplete-clangx supports neoinclude plugin
"
" https://github.com/Shougo/neoinclude.vim/
"
" neoinclude adds include directory options(-I) automatically for clang.
"
"
" ### ".clang" or ".clang_complete" file
"
" You can configure compiler options using the file.
"
" https://github.com/Rip-Rip/clang_complete#minimum-configuration
"
"
" ## Todo
"
" * compile_commands.json file support


"""""""""""""""""
" deoplete-jedi "
"""""""""""""""""
" # deoplete-jedi
"
"
" [deoplete.nvim](https://github.com/Shougo/deoplete.nvim) source for [jedi](https://github.com/davidhalter/jedi).
"
" || **Status** |
" |:---:|:---:|
" | **Travis CI** |[![Build Status](https://travis-ci.org/zchee/deoplete-jedi.svg?branch=master)](https://travis-ci.org/zchee/deoplete-jedi)|
" | **Gitter** |[![Join the chat at https://gitter.im/zchee/deoplete-jedi](https://badges.gitter.im/zchee/deoplete-jedi.svg)](https://gitter.im/zchee/deoplete-jedi?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)|
"
"
" ## Required
"
" - Neovim and neovim/python-client
"   - https://github.com/neovim/neovim
"   - https://github.com/neovim/python-client
"
" - deoplete.nvim
"   - https://github.com/Shougo/deoplete.nvim
"
" - jedi
"   - https://github.com/davidhalter/jedi
"
"
" ## Install
"
" ```vim
" NeoBundle 'deoplete-plugins/deoplete-jedi'
" # or
" Plug 'deoplete-plugins/deoplete-jedi'
" ```
"
" **Note:** If you don't want to use a plugin manager, you will need to clone
" this repo recursively:
"
" ```
" git clone --recursive https://github.com/deoplete-plugins/deoplete-jedi
" ```
"
" When updating the plugin, you will want to be sure that the Jedi submodule is
" kept up to date with:
"
" ```
" git submodule update --init
" ```
"
"
" ## Options
"
" - `g:deoplete#sources#jedi#statement_length`: Sets the maximum length of
"   completion description text.  If this is exceeded, a simple description is
"   used instead.
"   Default: `50`
" - `g:deoplete#sources#jedi#enable_typeinfo`: Enables type information of
"   completions.  If you disable it, you will get the faster results.
"   Default: `1`
" - `g:deoplete#sources#jedi#show_docstring`: Shows docstring in preview window.
"   Default: `0`
let g:deoplete#sources#jedi#show_docstring = 1
" - `g:deoplete#sources#jedi#python_path`: Set the Python interpreter path to use
"   for the completion server.  It defaults to "python", i.e. the first available
"   `python` in `$PATH`.
"   **Note**: This is different from Neovim's Python (`:python`) in general.
" - `g:deoplete#sources#jedi#extra_path`: A list of extra paths to add to
"   `sys.path` when performing completions.
" - `g:deoplete#sources#jedi#ignore_errors`: Ignore jedi errors for completions.
"   Default: `0`
" - `g:deoplete#sources#jedi#ignore_private_members`: Ignore private members from
"   completions.
"   Default: `0`
"
"
" ## Virtual Environments
"
" If you are using virtualenv, it is recommended that you create environments
" specifically for Neovim.  This way, you will not need to install the neovim
" package in each virtualenv.  Once you have created them, add the following to
" your vimrc file:
"
" ```vim
" let g:python_host_prog = '/full/path/to/neovim2/bin/python'
" let g:python3_host_prog = '/full/path/to/neovim3/bin/python'
" ```
"
" Deoplete only requires Python 3.  See `:h nvim-python-quickstart` for more
" information.
