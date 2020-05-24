" alternate file (source / header)
" don't want to use a.vim since it's old and problem-causing
function! s:AlternateFile()
    let map = {
                \ 'c': ['h'],
                \ 'cpp': ['h', 'hpp'],
                \ 'h': ['c', 'cpp'],
                \ 'hpp': ['cpp'] }
    let key = expand('%:e')
    if has_key(map, key)
        for ext in map[key]
            let filename = expand('%:p:r') . '.' . ext
            if filereadable(filename)
                e `=filename`
                break
            endif
        endfor
    endif
endfunction
command! AlternateFile :call s:AlternateFile()
