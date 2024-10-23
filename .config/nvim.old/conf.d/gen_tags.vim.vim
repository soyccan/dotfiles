" ------------------------------------------------------------------------------
" g:loaded_gentags#ctags                           *g:loaded_gentags#ctags*
"
" Set to 1 if you want to disable ctags support
"
" ------------------------------------------------------------------------------
" g:loaded_gentags#gtags                           *g:loaded_gentags#gtags*
"
" Set to 1 if you want to disable gtags support
"
" ------------------------------------------------------------------------------
" g:gen_tags#ctags_bin                            *g:gen_tags#ctags_bin*
"
" Set location of ctags. The default is 'ctags'
"
" ------------------------------------------------------------------------------
" g:gen_tags#gtags_bin                            *g:gen_tags#gtags_bin*
"
" Set location of gtags. The default is 'gtags'
"
" ------------------------------------------------------------------------------
" g:gen_tags#global_bin                           *g:gen_tags#global_bin*
"
" Set location of global; a binary of gtags. The default is 'global'
"
" ------------------------------------------------------------------------------
" g:gen_tags#ctags_opts                            *g:gen_tags#ctags_opts*
"
" Set ctags options. The `-R` is set by default,
" so there is no need to add `-R` in |g:gen_tags#ctags_opts|.
"
" |g:gen_tags#ctags_opts| is not defined by default.
" You need to set it in your vimrc as |string| or |list|
"
" For example:
" >
"   let g:gen_tags#ctags_opts = '--c++-kinds=+px --c-kinds=+px'
" <
" or
" >
"   let g:gen_tags#ctags_opts = ['--c++-kinds=+px', '--c-kinds=+px']
" >
let g:gen_tags#ctags_opts = []
let g:gen_tags#ctags_opts += ['--fields=+niazS']
let g:gen_tags#ctags_opts += ['--extra=+q']
let g:gen_tags#ctags_opts += ['--c++-kinds=+px']
let g:gen_tags#ctags_opts += ['--c-kinds=+px']
" ------------------------------------------------------------------------------
" g:gen_tags#gtags_opts                            *g:gen_tags#gtags_opts*
"
" Set gtags options. The database path is the default.
" The gtags options will be before the database path.
"
" |g:gen_tags#gtags_opts| is not defined by default.
" You need to set it in your vimrc as |string| or |list|
" >
"   let g:gen_tags#ctags_opts = '-c --verbose'
" <
" or
" >
"   let g:gen_tags#ctags_opts = ['-c', '--verbose']
" >
" ------------------------------------------------------------------------------
" g:gen_tags#use_cache_dir                        *g:gen_tags#_use_cache_dir*
"
" **This option only works for scm-repo.**
" Set the path of tags. If this variable is set to 1,
" |gen_tags.vim| will use project directory to store tags.
"
" The default |g:gen_tags#use_cache_dir| is 1, you need to set it in  your vimrc.
"
" 0:
"   scm repository:
"     git  `<project folder>/.git/tags_dir`
"     hg   `<project folder>/.hg/tags_dir`
"     scn  `<project folder>/.svn/tags_dir`
"   non-git: |g:gen_tags#cache_dir|
"
" 1:
"   use |g:gen_tags#cache_dir|
"
" ------------------------------------------------------------------------------
" g:gen_tags#cache_dir                               *g:gen_tags#cache_dir*
"
" This option allow to specify your own cache dir.
"
" The default |g:gen_tags#cache_dir| is `'$HOME/.cache/tags_dir/'`
"
" ------------------------------------------------------------------------------
" g:gen_tags#ctags_auto_gen                       *g:gen_tags#ctags_auto_gen*
"
" Auto generate ctags when this variable is 1 and current file belongs to
" a scm repository.
"
" The default |g:gen_tags#ctags_auto_gen| is 0
"
let g:gen_tags#ctags_auto_gen = 1
" ------------------------------------------------------------------------------
" g:gen_tags#gtags_auto_gen                       *g:gen_tags#gtags_auto_gen*
"
" Auto generate gtags when this variable is 1 and current file belongs to
" a scm repository.
"
" The default |g:gen_tags#gtags_auto_gen| is 0
"
let g:gen_tags#gtags_auto_gen = 1
" ------------------------------------------------------------------------------
" g:gen_tags#ctags_auto_update                 *g:gen_tags#ctags_auto_update*
"
" Auto update ctags on |BufWritePost|. Set 0 to disable it.
"
" The default |g:gen_tags#ctags_auto_update| is 1
"
" ------------------------------------------------------------------------------
" g:gen_tags#gtags_auto_update                 *g:gen_tags#gtags_auto_update*
"
" Auto update gtags on |BufWritePost|. set 0 to disable it.
"
" The default |g:gen_tags#gtags_auto_update| is 1
"
" ------------------------------------------------------------------------------
" g:gen_tags#blacklist                            *g:gen_tags#blacklist*
"
" A list to set the blacklist
" If the path in blacklist is equal `gen_tags#find_project_root()`,
" the generation of ctags/gtags will be skipped.
"
" The default |g:gen_tags#blacklist| is []
"
" e.g.: You can set it in your vimrc as below, it will blacklist `$HOME` dir
"
" `let g:gen_tags#blacklist = ['$HOME']`
"
" If you want to contain the sub-directory of some folders
" Please refer this issue https://github.com/jsfaint/gen_tags.vim/issues/43
"
" For example:
" >
"   let g:gen_tags#blacklist = split(glob('~/.vim/plugged/*'))
"   let g:gen_tags#blacklist += split(glob('~/.vim/*'))
" <
"
" ------------------------------------------------------------------------------
" g:gen_tags#verbose                              *g:gen_tags#verbose*
"
" Verbose mode to echo some message.
"
" The default |g:gen_tags#verbose| is 0
"
" ------------------------------------------------------------------------------
" g:gen_tags#ctags_prune                          *g:gen_tags#ctags_prune*
"
" Prune tags from tagfile for incremental update
" If |g:gen_tags#ctags_prune| is set to `1`, prune mode and ctags append mode will
" be use. |gen_tags.vim| will first prune the old tags for current file and then
" re-generate it with `ctags -a`, but `ctags -a` is buggy. So if your code base
" is not very large, just leave this option to `0`
"
" The default |g:gen_tags#ctags_prune| is `0`
"
" ------------------------------------------------------------------------------
" g:gen_tags#gtags_default_map                    *g:gen_tags#gtags_default_map*
"
" Enable/Disable default mapping for gtags_default_map.
"
" The default |g:gen_tags#gtags_default_map| is 1
"
" After set the |g:gen_tags#gtags_default_map| to 0, then you can map the
" following cscope commands in your vimrc.
" >
"     :cs find c <C-R>=expand('<cword>')<CR><CR>
"     :cs find d <C-R>=expand('<cword>')<CR><CR>
"     :cs find e <C-R>=expand('<cword>')<CR><CR>
"     :cs find f <C-R>=expand('<cfile>')<CR><CR>
"     :cs find g <C-R>=expand('<cword>')<CR><CR>
"     :cs find i <C-R>=expand('<cfile>')<CR><CR>
"     :cs find s <C-R>=expand('<cword>')<CR><CR>
"     :cs find t <C-R>=expand('<cword>')<CR><CR>
" <
" For more details, please refer help |cscope|
"
" ------------------------------------------------------------------------------
" g:gen_tags#statusline                           *g:gen_tags#statusline*
"
" Enable/Disable statusline feature.
" If |g:gen_tags#statusline| is 1, the statusline will show tags generating info,
" else nothing happened.
"
" The default |g:gen_tags#statusline| is 0
"
" ------------------------------------------------------------------------------
" g:gen_tags#root_marker                          *g:gen_tags#root_marker*
"
" Custom the root_marker which used for specify the project root.
"
" The default |g:gen_tags#root_marker| is '.root'
"
" ------------------------------------------------------------------------------
" g:gen_tags#root_path                          *g:gen_tags#root_path*
"
" Assign root path to set the project root. If set |g:gen_tags#root_path|, will
" ignore |g:gen_tags#root_marker|.
"
" ==============================================================================
