" *g:neomake_<ft>_enabled_makers*
" *b:neomake_<ft>_enabled_makers*
" This setting will tell Neomake which makers to use by default for the given
" filetype `<ft>` (when called without a maker as an argument, i.e. |:Neomake|).
"
" The default for this setting is the return value of the function
" `neomake#makers#ft#<ft>#EnabledMakers`.  For Python this is defined in
" `./autoload/neomake/makers/ft/python.vim`, and might return: >
"     ['python', 'frosted', 'pylama']
" <
" This setting can also be defined per buffer, so the following snippet can be
" used to configure a custom set of makers from your vimrc: >
"     let g:neomake_python_enabled_makers = ['pep8', 'pylint']
"     augroup my_custom_maker
"         au!
"         au Filetype custom.py let b:neomake_python_enabled_makers = ['flake8']
"     augroup END
" <
" Please refer to |autocmd-patterns| for help on defining the pattern
" (`custom.py`) in this case.
"
" Example:
"     let g:neomake_<ft>_<makername>_maker = {}
"     let g:neomake_<ft>_enabled_makers = []

" variants of shellcheck maker for different shells
" Refer to: neomake#makers#ft#sh#shellcheck()
let s:shellcheck = {
        \ 'args': ['-fgcc', '-x'],
        \ 'errorformat':
            \ '%f:%l:%c: %trror: %m [SC%n],' .
            \ '%f:%l:%c: %tarning: %m [SC%n],' .
            \ '%I%f:%l:%c: Note: %m [SC%n]',
        \ 'output_stream': 'stdout',
        \ 'short_name': 'SC',
        \ 'cwd': '%:h',
        \ }

let s:posixcheck = deepcopy(s:shellcheck)
let s:posixcheck.exe = 'shellcheck'
let s:posixcheck.args += ['-s', 'sh']

let s:bashcheck = deepcopy(s:shellcheck)
let s:bashcheck.exe = 'shellcheck'
let s:bashcheck.args += ['-s', 'bash']

let g:neomake_sh_posixcheck_maker = s:posixcheck
let g:neomake_sh_bashcheck_maker = s:bashcheck

let g:neomake_zsh_posixcheck_maker = s:posixcheck
let g:neomake_zsh_bashcheck_maker = s:bashcheck

" Specifying 'shellcheck' (already defined) makes shell type automatically
" determined, but zsh is not supported by shellcheck, so we see it as bash
let g:neomake_sh_enabled_makers = ['sh', 'shellcheck']
let g:neomake_zsh_enabled_makers = ['zsh', 'bashcheck']

" *g:neomake_highlight_columns*
" This setting enables highlighting of columns for items from the location and
" quickfix list. Defaults to 1.
let g:neomake_highlight_columns = 1

" If you want to run Neomake automatically (in file mode), you can configure it
" in your `vimrc` by using `neomake#configure#automake`, e.g. by picking one of:
"
" ```vim
" " When writing a buffer (no delay).
" call neomake#configure#automake('w')
" " When writing a buffer (no delay), and on normal mode changes (after 750ms).
" call neomake#configure#automake('nw', 750)
" " When reading a buffer (after 1s), and when writing (no delay).
" call neomake#configure#automake('rw', 1000)
" " Full config: when writing or reading a buffer, and on changes in insert and
" " normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrwi', 500)
" ```
"
" (Any function calls like these need to come after indicating the end of plugins
" to your plugin manager, e.g. after `call plug#end()` with vim-plug.)
"
" ### Advanced setup
"
" The author liked to use the following, which uses different modes based on if
" your laptop runs on battery (for MacOS or Linux):
"
" ```vim
" function! MyOnBattery()
"   if has('macunix')
"     return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
"   elseif has('unix')
"     return readfile('/sys/class/power_supply/AC/online') == ['0']
"   endif
"   return 0
" endfunction
"
" if MyOnBattery()
"   call neomake#configure#automake('w')
" else
"   call neomake#configure#automake('nw', 1000)
" endif
" ```
"
" See `:help neomake-automake` (in [doc/neomake.txt](doc/neomake.txt)) for more
" information, e.g. how to configure it based on certain autocommands explicitly,
" and for details about which events get used for the different string-based
" modes.
"
" ## Usage
"
" When calling `:Neomake` manually (or automatically through
" `neomake#configure#automake` (see above)) it will populate the window's
" location list with any issues that get reported by the maker(s).
"
" You can then navigate them using the built-in methods like `:lwindow` /
" `:lopen` (to view the list) and `:lprev` / `:lnext` to go back and forth.
"
" You can configure Neomake to open the list automatically:
"
" ```vim
" let g:neomake_open_list = 2
" ```
"
" Please refer to [`:help neomake.txt`] for more details on configuration.
"
" ### Maker types
"
" There are two types of makers: file makers (acting on the current buffer) and
" project makers (acting globally).
"
" You invoke file makers using `:Neomake`, and project makers using `:Neomake!`.
"
" See [`:help neomake.txt`] for more details.
"
" ### Manually run a maker
"
" You can run a specific maker on the current file by specifying the maker's
" name, e.g. `:Neomake jshint` (you can use Vim's completion here to complete
" maker names).
