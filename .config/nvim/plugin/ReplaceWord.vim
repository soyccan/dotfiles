function! ReplaceWordUnderCursor(replacement)
    " Replace all occurrences of the word under the cursor
    let word = expand('<cword>')

    " \< \> specifies word boundary
    execute ':%s/\<' . word . '\>/' . a:replacement . '/g'
endfunction

function! ReplaceStringUnderCursor(replacement)
    " Replace all occurrences of the word under the cursor
    let word = expand('<cword>')

    " Unlike ReplaceWordUnderCursor(), this does not require word boundary but
    " include all substrings
    execute ':%s/' . word . '/' . a:replacement . '/g'
endfunction

command! -nargs=1 ReplaceWord :call ReplaceWordUnderCursor(<q-args>)
command! -nargs=1 ReplaceString :call ReplaceStringUnderCursor(<q-args>)

