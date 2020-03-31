let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'cpp': ['clangformat'],
\   'c': ['clangformat'],
\   'python': ['flake8', 'pylint'],
\   'bash': ['shellcheck'],
\}

" let g:ale_sign_column_always = 1
" let g:ale_completion_delay = 500
" let g:ale_echo_delay = 20
" let g:ale_lint_delay = 500
" let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1
"
"let g:ale_set_quickfix = 1
"let g:ale_open_list = 1"打开quitfix对话框

let g:ale_c_clang_options = '-Wall -Wextra -Wconversion -std=c17'
let g:ale_cpp_clang_options = '-Wall -Wextra -Wconversion -std=c++17'
let g:ale_c_gcc_options = '-Wall -Wextra -Wconversion -std=c17'
let g:ale_cpp_gcc_options = '-Wall -Wextra -Wconversion -std=c++17'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_python_flake8_options = '--jobs=4'
let g:ale_python_pylint_options = '--jobs=4'

" let g:ale_sign_error = ">>"
" let g:ale_sign_warning = "--"

" hi! clear SpellBad
" hi! clear SpellCap
" hi! clear SpellRare
" hi! SpellBad gui=undercurl guisp=red
" hi! SpellCap gui=undercurl guisp=blue
" hi! SpellRare gui=undercurl guisp=magenta
