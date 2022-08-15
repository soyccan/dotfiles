" press 0 for HOME / (non-blank) HOME / END, alternatively
function! s:Smart0()
    if col('.') == len(getline('.'))
        " if cursor is at end of line
        norm! ^

    elseif match(strpart(getline('.'), 0, col('.')), '^\s\+\S$') != -1
        " if cursor is at first non-space character
        norm! 0

    else
        norm! ^

    endif

endfunction

command! Smart0 call <SID>Smart0()
