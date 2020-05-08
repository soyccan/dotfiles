function! s:CutTrail()
"   in recently yanked text only
"   let [first, last] = [line("'["), line("']")]
"   in recently selected text only
"   let [first, last] = [line("'<"), line("'>")]

    let [first, last] = [1, line('$')]
    for lnum in range(first, last)
        let line = getline(lnum)
        let line = substitute(line, '\s\+$', '', '')
        call setline(lnum, line)
    endfor
endfunction

" autocmd BufWrite * call <SID>CutTrail()
