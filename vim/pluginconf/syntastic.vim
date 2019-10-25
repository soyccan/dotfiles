set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}%*
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 10
let g:syntastic_mode_map = {
    \'mode': 'passive',
    \'active_filetypes': [],
    \'passive_filetypes': [] }

let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = "-Wall -Wextra -std=c++17"

let g:syntastic_python_checkers = ['pylint']
"let g:syntastic_python_exec = 'python'
"let g:syntastic_python_args = ['-m', 'py_compile']

let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_standard_generic = 1
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exec = 'eslint'

" re-enable gcc linter when YouCompleteMe is installed
let g:ycm_show_diagnostics_ui = 0
