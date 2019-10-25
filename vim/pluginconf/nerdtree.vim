function! s:AutoNerdTree()
    " open a NERDTree automatically when vim starts up if no files were specified
    "if argc() == 0 && !exists("s:std_in")
    "    NERDTree
    "endif

    " open NERDTree automatically when vim starts up on opening a directory
    if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
        exe 'NERDTree' argv()[0]
        wincmd p
        ene
    endif

    " close vim if the only window left open is a NERDTree
    if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
        q
    endif
endfunction

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * call s:AutoNerdTree()
autocmd VimEnter * call s:AutoNerdTree()
