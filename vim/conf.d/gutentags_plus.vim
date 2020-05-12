" ===============================================================================
"                                                         *gutentags_plus-command*
" Command ~
" >
"   :GscopeFind {querytype} {name}
" <
" Perform a cscope search and take care of database switching before searching.
"
" '{querytype}' corresponds to the actual cscope line interface numbers as well
" as default nvi commands:
" >
"   0 or s: Find this symbol
"   1 or g: Find this definition
"   2 or d: Find functions called by this function
"   3 or c: Find functions calling this function
"   4 or t: Find this text string
"   6 or e: Find this egrep pattern
"   7 or f: Find this file
"   8 or i: Find files #including this file
"   9 or a: Find places where this symbol is assigned a value
" <
" ===============================================================================
"                                                         *gutentags_plus-keymaps*
" Keymaps ~
" >
"   noremap <silent> <leader>cs :GscopeFind s <C-R><C-W><cr>
"   noremap <silent> <leader>cg :GscopeFind g <C-R><C-W><cr>
"   noremap <silent> <leader>cc :GscopeFind c <C-R><C-W><cr>
"   noremap <silent> <leader>ct :GscopeFind t <C-R><C-W><cr>
"   noremap <silent> <leader>ce :GscopeFind e <C-R><C-W><cr>
"   noremap <silent> <leader>cf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
"   noremap <silent> <leader>ci :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
"   noremap <silent> <leader>cd :GscopeFind d <C-R><C-W><cr>
"   noremap <silent> <leader>ca :GscopeFind a <C-R><C-W><cr>
" <
" You can disable the default keymaps by:
" >
let g:gutentags_plus_nomap = 1
" <
" and define your new maps like:
" >
"   noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
"   noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
"   noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
"   noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
"   noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
"   noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
"   noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
"   noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
"   noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
" <
" ===============================================================================
