let g:formatterpath = ['/some/path/to/a/folder', '/home/superman/formatters']

" auto format on save
au BufWrite * :Autoformat


" To disable the fallback to vim's indent file, retabbing and removing trailing
" whitespace, set the following variables to 0.
" let g:autoformat_autoindent = 0
" let g:autoformat_retab = 0
" let g:autoformat_remove_trailing_spaces = 0

" To disable or re-enable these option for specific buffers, use the buffer local variants:
" b:autoformat_autoindent, b:autoformat_retab and b:autoformat_remove_trailing_spaces.
" So to disable autoindent for filetypes that have incompetent indent files, use:
autocmd FileType vim,tex let b:autoformat_autoindent=0

" You can manually autoindent, retab or remove trailing whitespace with the following respective commands.
" gg=G
" :retab
" :RemoveTrailingSpaces

" Default formatters: vim-autoformat/plugin/defaults.vim
" g:formatters_<filetype> is a list containing string identifiers, which point to
" corresponding formatter definitions.
" The formatter definitions themselves are defined in g:formatdef_<identifier> as a string expression.
" Defining any of these variable manually in your .vimrc, will override the default value, if existing.
" For example, a complete definition in your .vimrc for C# files could look like this:
" let g:formatdef_my_custom_cs = '"astyle --mode=cs --style=ansi -pcHs4"'
" let g:formatters_cs = ['my_custom_cs']
let g:formatters_c = ['clangformat']
let g:formatters_cpp = ['clangformat']
let g:formatters_python = ['autopep8']


" Ranged definitions
" If your format program supports formatting specific ranges, you can provide a format definition which
" allows to make use of this. The first and last line of the current range can be retrieved by the variables
" a:firstline and a:lastline. They default to the first and last line of your file, if no range was
" explicitly specified. So, a ranged definition could look like this.
"   let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
"   let g:formatters_python = ['autopep8']
" This would allow the user to select a part of the file and execute :Autoformat, which would then only format the selected part.
