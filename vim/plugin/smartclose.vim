" TODO: still not complete
" this code refers to tagbar.vim
" it aims to wisely close window or delete buffer when called
" and it should handle when quickfix or location list window exists
" function! s:TagbarBufName() abort
"     if !exists('t:tagbar_buf_name')
"         let s:buffer_seqno += 1
"         let t:tagbar_buf_name = '__Tagbar__.' . s:buffer_seqno
"     endif
"
"     return t:tagbar_buf_name
" endfunction
"
" function! s:HasOpenFileWindows() abort
"     for i in range(1, winnr('$'))
"         let buf = winbufnr(i)
"
"         " skip unlisted buffers, except for netrw
"         if !buflisted(buf) && getbufvar(buf, '&filetype') !=# 'netrw'
"             continue
"         endif
"
"         " skip temporary buffers with buftype set
"         if getbufvar(buf, '&buftype') !=# ''
"             continue
"         endif
"
"         " skip the preview window
"         if getwinvar(i, '&previewwindow')
"             continue
"         endif
"
"         return 1
"     endfor
"
"     return 0
" endfunction
"
" function! s:HandleBufDelete(bufname, bufnr) abort
"     " Ignore autocmd events generated for "set nobuflisted",
"     let nr = str2nr(a:bufnr)
"     if bufexists(nr) && !buflisted(nr)
"         return
"     endif
"
"     let tagbarwinnr = bufwinnr(s:TagbarBufName())
"     if tagbarwinnr == -1 || a:bufname =~# '__Tagbar__.*'
"         return
"     endif
"
"     call s:known_files.rm(fnamemodify(a:bufname, ':p'))
"
"     if !s:HasOpenFileWindows()
"         if tabpagenr('$') == 1 && exists('t:tagbar_buf_name')
"             " The last normal window closed due to a :bdelete/:bwipeout.
"             " In order to get a normal file window back switch to the last
"             " alternative buffer (or a new one if there is no alternative
"             " buffer), reset the Tagbar-set window options, and then re-open
"             " the Tagbar window.
"
"             " Ignore the buffer to be deleted, just in case
"             call setbufvar(a:bufname, 'tagbar_ignore', 1)
"
"             if s:last_alt_bufnr == -1 || s:last_alt_bufnr == expand('<abuf>')
"                 if argc() > 1 && argidx() < argc() - 1
"                     " We don't have an alternative buffer, but there are still
"                     " files left in the argument list
"                     next
"                 else
"                     enew
"                 endif
"             else
"                 " Save a local copy as the global value will change
"                 " during buffer switching
"                 let last_alt_bufnr = s:last_alt_bufnr
"
"                 " Ignore the buffer we're switching to for now, it will get
"                 " processed due to the OpenWindow() call anyway
"                 call setbufvar(last_alt_bufnr, 'tagbar_ignore', 1)
"                 execute 'keepalt buffer' last_alt_bufnr
"                 call setbufvar(last_alt_bufnr, 'tagbar_ignore', 0)
"             endif
"
"             " Reset Tagbar window-local options
"             set winfixwidth<
"
"             call s:OpenWindow('')
"         elseif exists('t:tagbar_buf_name')
"             close
"         endif
"     endif
" endfunction

" autocmd BufDelete * call <SID>HandleBufDelete(expand('<afile>'), expand('<abuf>'))


" adding following command will fix the problem that quickfix will open
" inside tagbar:
"   autocmd filetype qf wincmd J

function! s:SmartClose()
    if &buftype != ''
        " if current window is not a normal buffer
        " e.g. being quickfix, tagbar ...
        close
        return
    endif

    " wincnt: #windows that are normal buffers
    " (other than quickfix, location list, tagbar...)
    let wincnt = winnr('$')
    let tagbar_exists = 0
    let quickfix_exists = 0

    if exists('t:tagbar_buf_name') && bufwinnr(t:tagbar_buf_name) != -1
        " if tagbar exists
        let tagbar_exists = 1
        let wincnt -= 1
        TagbarClose
    endif
    if !empty(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"'))
        " if quickfix window exists
        let quickfix_exists = 1
        let wincnt -= 1
        cclose
    end

    if wincnt == 1 && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
        " if there is one window and multiple buffers
        bdelete
    else
        q
    endif

    " reopen quickfix or tagbar
    if tagbar_exists
        let curwin = winnr()
        TagbarOpen
        execute curwin . 'wincmd w'
    endif
    if quickfix_exists
        let curwin = winnr()
        copen
        execute curwin . 'wincmd w'
    endif
endfunction

command! SmartClose call <SID>SmartClose()
