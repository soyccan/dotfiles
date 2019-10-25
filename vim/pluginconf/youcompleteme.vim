" require installation, see github
let g:ycm_clangd_binary_path = "~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/third_party/"
let g:ycm_clangd_args = ['-background-index']
let g:ycm_global_ycm_extra_conf = "~/.config/nvim/ycm_extra_conf.py"
let g:ycm_use_clangd = 1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'


set completeopt=menu,menuone " close popup quickfix
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-y>'
noremap <c-y> <NOP>
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }
