" The *g:ycm_clangd_args* option
"
" This option controls the command line arguments passed to the clangd binary. It
" appends new options and overrides the existing ones.
"
" Default: '[]'
" >
let g:ycm_clangd_args = ['-j=4']
" <
" -------------------------------------------------------------------------------
" The *g:ycm_show_diagnostics_ui* option
"
" When set, this option turns on YCM's diagnostic display features. See the
" _Diagnostic display_ section in the _User Manual_ for more details.
"
" Specific parts of the diagnostics UI (like the gutter signs, text highlighting,
" diagnostic echo and auto location list population) can be individually turned
" on or off. See the other options below for details.
"
" Note that YCM's diagnostics UI is only supported for C-family languages.
"
" When set, this option also makes YCM remove all Syntastic checkers set for the
" 'c', 'cpp', 'objc', 'objcpp', and 'cuda' filetypes since this would conflict
" with YCM's own diagnostics UI.
"
" If you're using YCM's identifier completer in C-family languages but cannot use
" the clang-based semantic completer for those languages _and_ want to use the
" GCC Syntastic checkers, unset this option.
"
" Default: '1'
" >
let g:ycm_show_diagnostics_ui = 0
" <
" -------------------------------------------------------------------------------
" The *g:ycm_key_list_stop_completion* option
"
" This option controls the key mappings used to close the completion menu. This
" is useful when the menu is blocking the view, when you need to insert the
" '<TAB>' character, or when you want to expand a snippet from UltiSnips [25] and
" navigate through it.
"
" Default: "['<C-y>']"
" >
let g:ycm_key_list_stop_completion = ['<C-y>']
" <
" -------------------------------------------------------------------------------
" The *g:ycm_semantic_triggers* option
"
" This option controls the character-based triggers for the various semantic
" completion engines. The option holds a dictionary of key-values, where the keys
" are Vim's filetype strings delimited by commas and values are lists of strings,
" where the strings are the triggers.
"
" Setting key-value pairs on the dictionary _adds_ semantic triggers to the
" internal default set (listed below). You cannot remove the default triggers,
" only add new ones.
"
" A "trigger" is a sequence of one or more characters that trigger semantic
" completion when typed. For instance, C++ ('cpp' filetype) has '.' listed as a
" trigger. So when the user types 'foo.', the semantic engine will trigger and
" serve 'foo''s list of member functions and variables. Since C++ also has '->'
" listed as a trigger, the same thing would happen when the user typed 'foo->'.
"
" It's also possible to use a regular expression as a trigger. You have to prefix
" your trigger with 're!' to signify it's a regex trigger. For instance,
" 're!\w+\.' would only trigger after the '\w+\.' regex matches.
"
" **NOTE:** The regex syntax is **NOT** Vim's, it's Python's [74].
"
" Default: '[see next line]'
" >
"   let g:ycm_semantic_triggers =  {
"     \   'c': ['->', '.'],
"     \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
"     \            're!\[.*\]\s'],
"     \   'ocaml': ['.', '#'],
"     \   'cpp,cuda,objcpp': ['->', '.', '::'],
"     \   'perl': ['->'],
"     \   'php': ['->', '::'],
"     \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
"     \   'ruby,rust': ['.', '::'],
"     \   'lua': ['.', ':'],
"     \   'erlang': [':'],
"     \ }
" <
" -------------------------------------------------------------------------------
" Enable debugging
" let g:ycm_keep_logfiles = 1
" let g:ycm_log_level = 'debug'
"
"
"
"
"
"
"
"
" require installation, see github
" let g:ycm_clangd_binary_path = "~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/third_party/"
" let g:ycm_clangd_args = ['-background-index']
" let g:ycm_global_ycm_extra_conf = "~/.config/nvim/ycm_extra_conf.py"
" let g:ycm_use_clangd = 1
" let g:ycm_error_symbol = '>>'
" let g:ycm_warning_symbol = '>*'
"
"
" set completeopt=menu,menuone " close popup quickfix
" let g:ycm_add_preview_to_completeopt = 0
" let g:ycm_show_diagnostics_ui = 0
" let g:ycm_server_log_level = 'info'
" let g:ycm_min_num_identifier_candidate_chars = 2
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_complete_in_strings=1
" let g:ycm_key_invoke_completion = '<c-y>'
" noremap <c-y> <NOP>
" let g:ycm_semantic_triggers =  {
"             \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
"             \ 'cs,lua,javascript': ['re!\w{2}'],
"             \ }
