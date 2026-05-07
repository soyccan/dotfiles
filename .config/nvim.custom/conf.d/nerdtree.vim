" The NERDTree [![Vint](https://github.com/preservim/nerdtree/workflows/Vint/badge.svg)](https://github.com/preservim/nerdtree/actions?workflow=Vint)
" =============
"
" Introduction
" ------------
"
" The NERDTree is a file system explorer for the Vim editor. Using this plugin,
" users can visually browse complex directory hierarchies, quickly open files for
" reading or editing, and perform basic file system operations.
"
" This plugin can also be extended with custom mappings using a special API. The
" details of this API and of other NERDTree features are described in the
" included documentation.
"
" ![NERDTree Screenshot](https://github.com/preservim/nerdtree/raw/master/screenshot.png)
"
" F.A.Q. (here, and in the [Wiki](https://github.com/preservim/nerdtree/wiki))
" ------
" #### How can I open a NERDTree automatically when vim starts up?
"
" Stick this in your vimrc: `autocmd vimenter * NERDTree`
"
" ---
" #### How can I open a NERDTree automatically when vim starts up if no files were specified?
"
" Stick this in your vimrc:
" ```vim
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" ```
"
" Note: Now start vim with plain `vim`, not `vim .`
"
" ---
" #### What if I'm also opening a saved session, for example `vim -S session_file.vim`? I don't want NERDTree to open in that scenario.
" ```vim
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
" ```
"
" ---
" #### How can I open NERDTree automatically when vim starts up on opening a directory?
" ```vim
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" ```
"
" This window is tab-specific, meaning it's used by all windows in the tab. This trick also prevents NERDTree from hiding when first selecting a file.
"
" Note: Executing `vim ~/some-directory` will open NERDTree and a new edit window. `exe 'cd '.argv()[0]` sets the `pwd` of the new edit window to `~/some-directory`
"
" ---
" #### How can I map a specific key or shortcut to open NERDTree?
"
" Stick this in your vimrc to open NERDTree with `Ctrl+n` (you can set whatever key you want):
" ```vim
" map <C-n> :NERDTreeToggle<CR>
" ```
"
" ---
" #### How can I close vim if the only window left open is a NERDTree?
"
" Stick this in your vimrc:
" ```vim
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" ```
"
" ---
" #### Can I have different highlighting for different file extensions?
"
" See here: https://github.com/preservim/nerdtree/issues/433#issuecomment-92590696
"
" ---
" #### How can I change default arrows?
"
" Use these variables in your vimrc. Note that below are default arrow symbols
" ```vim
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" ```
" You can remove the arrows altogether by setting these variables to empty strings, as shown below. This will remove not only the arrows, but a single space following them, shifting the whole tree two character positions to the left.
" ```vim
" let g:NERDTreeDirArrowExpandable = ''
" let g:NERDTreeDirArrowCollapsible = ''
" ```








" function! s:AutoNerdTree()
"     " open a NERDTree automatically when vim starts up if no files were specified
"     "if argc() == 0 && !exists("s:std_in")
"     "    NERDTree
"     "endif
"
"     " open NERDTree automatically when vim starts up on opening a directory
"     if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
"         exe 'NERDTree' argv()[0]
"         wincmd p
"         ene
"     endif
"
"     " close vim if the only window left open is a NERDTree
"     if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
"         q
"     endif
" endfunction
"
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * call s:AutoNerdTree()
" autocmd VimEnter * call s:AutoNerdTree()
