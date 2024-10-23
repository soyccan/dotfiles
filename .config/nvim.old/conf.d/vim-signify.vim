" Delayed until g:signify_vcs_cmds is set
let g:signify_vcs_cmds = {
    \ 'git': 'git diff --no-color --no-ext-diff --ignore-all-space -U0 -- %f'}

" Ignore all white space
let g:signify_difftool = 'diff -w'
