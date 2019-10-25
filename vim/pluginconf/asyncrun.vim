" height
let g:asyncrun_open = 6

" ring after finish
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
" nnoremap <F10> :call asyncrun#quickfix_toggle(6)<CR>

let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
