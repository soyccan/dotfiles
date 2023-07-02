"                                                      *asyncrun-quickfix-window*
" Quickfix window ~
"
" AsyncRun displays its output in quickfix window, so if you don't use ':copen
" {height}' to open quickfix window, you won't see any output. For convenience
" there is an option 'g:asyncrun_open' for you:
" >
let g:asyncrun_open = 8
" <
" Setting 'g:asyncrun_open' to 8 will open quickfix window automatically at 8
" lines height after command starts.
"
let g:asyncrun_rootmarks = ['.gitignore', '.clang-format',
            \               'README', 'README.md', 'README.txt',
            \               '.projectroot', '.root',
            \               '.git', '.hg', '.svn', '.bzr', '_darcs',
            \               'build.xml', 'CMakeLists.txt']



" height
" let g:asyncrun_open = 6
"
" " ring after finish
" let g:asyncrun_bell = 1
"
" " 设置 F10 打开/关闭 Quickfix 窗口
" " nnoremap <F10> :call asyncrun#quickfix_toggle(6)<CR>
"
" let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
