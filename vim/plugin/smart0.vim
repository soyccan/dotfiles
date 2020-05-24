" press 0 for HOME / (non-blank) HOME / END, alternatively
function! s:smart0()
    " TODO; this function cause 'd0' to behave wrongly
    if col('.') == len(getline('.'))
        norm! 0
    elseif col('.') == 1 && (getline('.')[0] == ' ' || getline('.')[0] == '\t')
        norm! ^
    else
        norm! $
    endif
endfunction
" map <silent> 0 :call <SID>AlternateHomeEnd()<CR>

