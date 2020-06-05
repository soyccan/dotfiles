" original was:
"    autocmd VimEnter  *  if expand('<amatch>')==''|call gutentags#setup_gutentags()|endif
" which don't run when open a file by: vim filename
" I don't if this is correct, but it works
autocmd VimEnter * if exists('*gutentags#setup_gutentags')|call gutentags#setup_gutentags()|endif

"                                                 *gutentags_enabled*
" g:gutentags_enabled
"                         Defines whether Gutentags should be enabled. When
"                         disabled, Gutentags will still scan for project root
"                         markers when opening buffers. This is so that when you
"                         re-enable Gutentags, you won't have some buffers
"                         mysteriously working while others (those open last)
"                         don't.
"                         Defaults to `1`.
"
"                                                 *gutentags_trace*
let g:gutentags_trace = 0
"                         When true, Gutentags will spit out debugging
"                         information as Vim messages (which you can later read
"                         with |:messages|). It also runs its background scripts
"                         with extra parameters to log activity to a `tags.log`
"                         file that you can also inspect for more information.
"
"                         Note: you can run `:verbose GutentagsUpdate` to
"                         temporarily set |g:gutentags_trace| to `1` for that
"                         update only.
"
"                         Defaults to `0`.
"
"                                                 *gutentags_dont_load*
" g:gutentags_dont_load
"                         Prevents Gutentags from loading at all on Vim startup.
"
"                         The difference between this and |gutentags_enabled| is
"                         that |gutentags_enabled| can be turned on and off in
"                         the same Vim session -- Gutentags as a plugin stays
"                         loaded and will keep track of what happened while it
"                         was disabled. However, |gutentags_dont_load| only
"                         works on Vim startup and will prevent Gutentags from
"                         loading at all, as if it wasn't there.
"
"                                                 *gutentags_modules*
let g:gutentags_modules = []
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
"                         A list of modules to load with Gutentags. Each module
"                         is responsible for generating a specific type of tags
"                         file.
"                         Valid values are:
"
"                         - `ctags`: generates a `tags` file using
"                           a `ctags`-compatible program like Exhuberant Ctags
"                           or Universal Ctags.
"
"                         - `cscope`: generates a code database file using
"                           `cscope`.
"
"                         - `gtags_cscope`: same as `cscope` but uses GNU's
"                           `gtags` executable and database.
"
"                         Defaults to `[ctags]`.
"
"                                                 *gutentags_project_root*
" let g:gutentags_project_root = ['.gitignore', 'Makefile', 'README']
"                         When a buffer is loaded, Gutentags will figure out if
"                         it's part of a project that should have tags managed
"                         automatically. To do this, it looks for "root markers"
"                         in the current file's directory and its parent
"                         directories. If it finds any of those markers,
"                         Gutentags will be enabled for the project, and a tags
"                         file named after |gutentags_ctags_tagfile| will be
"                         created at the project root.
"                         Defaults to `[]` (an empty |List|).
"                         A list of default markers will be appended to the
"                         user-defined ones unless
"                         |gutentags_add_default_project_roots| is set to 0.
"
"                                             *gutentags_add_default_project_roots*
" g:gutentags_add_default_project_roots
"                         Defines whether Gutentags should always define some
"                         default project roots (see |gutentags_project_root|).
"                         This can be useful to prevent unnecessary disk access
"                         when Gutentags searches for a project root.
"                         The default markers are:
"                         `['.git', '.hg', '.svn', '.bzr', '_darcs', '_darcs', '_FOSSIL_', '.fslckout']`
"
"                                             *gutentags_add_ctrlp_root_markers*
" g:gutentags_add_ctrlp_root_markers
"                         If Gutentags finds `g:ctrlp_root_markers` (used by the
"                         CtrlP plugin), it will append those root markers to
"                         the existing ones (see |g:gutentags_project_root|).
"                         Set this to 0 to stop it from happening.
"                         Defaults to 1.
"
"                                                 *gutentags_exclude_filetypes*
" g:gutentags_exclude_filetypes
"                         A |List| of file types (see |'filetype'|) that Gutentags
"                         should ignore. When a buffer is opened, if its
"                         'filetype' is found in this list, Gutentags features
"                         won't be available for this buffer.
"                         Defaults to an empty list (`[]`).
"
"                                                 *gutentags_exclude_project_root*
" g:gutentags_exclude_project_root
"                         A list of project roots to generally ignore. If a file
"                         is opened inside one of those projects, Gutentags
"                         won't be activated. This is similar to placing
"                         a `.notags` file in the root of those projects, but
"                         can be useful when you don't want to, or can't, place
"                         such a file there.
"                         Defaults to `['/usr/local']`, which is the folder where
"                         Homebrew is known to create a Git directory by default
"                         on MacOS.
"
"                                                 *gutentags_project_root_finder*
let g:gutentags_project_root_finder = 'asyncrun#get_root'
"                         When a buffer is loaded, Gutentags uses a default
"                         (internal) implementation to find that file's
"                         project's root directory, using settings like
"                         |g:gutentags_project_root|. When you specify
"                         |g:gutentags_project_root_finder|, you can tell
"                         Gutentags to use a custom implementation, such as
"                         `vim-projectroot`. The value of this setting must be
"                         the name of a function that takes a single string
"                         argument (the path to the current buffer's file) and
"                         returns a string value (the project's root directory).
"                         Defaults to `''`.
"                         Note: when set, the called implementation will
"                         possibly ignore |g:gutentags_project_root|.
"                         Note: an implementation can fallback to the default
"                         behaviour by calling
"                         `gutentags#default_get_project_root`.
"
"                                                 *gutentags_generate_on_missing*
" g:gutentags_generate_on_missing
"                         If set to 1, Gutentags will start generating an initial
"                         tag file if a file is open in a project where no tags
"                         file is found. See |gutentags_project_root| for how
"                         Gutentags locates the project.
"                         When set to 0, Gutentags will only generate the first
"                         time the file is saved (if
"                         |gutentags_generate_on_write| is set to 1), or when
"                         |GutentagsUpdate| or |GutentagsGenerate| is run.
"                         Defaults to 1.
"
"                                                 *gutentags_generate_on_new*
" g:gutentags_generate_on_new
"                         If set to 1, Gutentags will start generating the tag
"                         file when a new project is open. A new project is
"                         considered open when a buffer is created for a file
"                         whose corresponding tag file has not been "seen" yet
"                         in the current Vim session -- which pretty much means
"                         when you open the first file in a given source control
"                         repository.
"                         When set to 0, Gutentags won't do anything special.
"                         See also |gutentags_generate_on_missing| and
"                         |gutentags_generate_on_write|.
"                         Defaults to 1.
"
"                                                 *gutentags_generate_on_write*
" g:gutentags_generate_on_write
"                         If set to 1, Gutentags will update the current
"                         project's tag file when a file inside that project is
"                         saved. See |gutentags_project_root| for how Gutentags
"                         locates the project.
"                         When set to 0, Gutentags won't do anything on save.
"                         This means that the project's tag file won't reflect
"                         the latest changes, and you will have to run
"                         |GutentagsUpdate| manually.
"                         Defaults to 1.
"
"                                             *gutentags_generate_on_empty_buffer*
" g:gutentags_generate_on_empty_buffer
"                         If set to 1, Gutentags will start generating the tag
"                         file even if there's no buffer currently open, as long
"                         as the current working directory (as returned by
"                         |:cd|) is inside a known project.
"                         This is useful if you want Gutentags to generate the
"                         tag file right after opening Vim.
"                         Defaults to 0.
"
"                                                 *gutentags_background_update*
" g:gutentags_background_update
"                         Specifies whether the process that updates the tags
"                         file should be run in the background or in the
"                         foreground. If run in the foreground, Vim will block
"                         until the process is complete.
"                         Defaults to 1.
"
"                                                 *gutentags_cache_dir*
let g:gutentags_cache_dir = expand('~/.cache/nvim/tags')
"                         Specifies a directory in which to create all the tags
"                         files, instead of writing them at the root of each
"                         project. This is handy to keep tags files from
"                         polluting many directories all across your computer.
"
"                                             *gutentags_resolve_symlinks*
" g:gutentags_resolve_symlinks
"                         When set to 1, Gutentags will resolve any symlinks in
"                         the current buffer's path in order to find the project
"                         it belongs to. This is what you want if you're editing
"                         a symlink located outside of the project, and it
"                         points to a file inside the project. However, this is
"                         maybe not what you want if the symlink itself is
"                         part of the project.
"                         Defaults to 0.
"
"                                             *gutentags_init_user_func*
" g:gutentags_init_user_func
"                         When set to a non-empty string, it is expected to be
"                         the name of a function that will be called when a file
"                         is opened in a project. The function gets passed the
"                         path of the file and if it returns 0, Gutentags won't
"                         be enabled for that file.
"
"                         You can use this to manually set buffer-local
"                         settings:
"
"                         * `b:gutentags_ctags_tagfile` (see |gutentags_ctags_tagfile|).
"
"                         This setting was previously called
"                         `gutentags_enabled_user_func`. The old setting is
"                         still used as a fallback.
"
"                         Defaults to "".
"
"                                             *gutentags_define_advanced_commands*
let g:gutentags_define_advanced_commands = 1
"                         Defines some advanced commands like
"                         |GutentagsToggleEnabled| and |GutentagsUnlock|.
"
"                                             *gutentags_project_info*
" g:gutentags_project_info
"                         Defines ways for Gutentags to figure out what kind of
"                         project any given file belongs to. This should be
"                         a list of dictionaries:
"
"                         let g:gutentags_project_info = []
"                         call add(g:gutentags_project_info, {...})
"
"                         Each dictionary item must contain at least a `type`
"                         key, indicating the type of project:
"
"                         {"type": "python"}
"
"                         Other items will be used to figure out if a project is
"                         of the given type.
"
"                         "file": any existing file with this path (relative to
"                         the project root) will make the current project match
"                         the given info.
"
"                         "glob": any result found with this glob pattern
"                         (relative to the project root) will make the current
"                         project match the given info. See |glob()| for more
"                         information.
"
"                         Gutentags adds by default the following definitions:
"
"                         call add(g:gutentags_project_info, {'type': 'python', 'file': 'setup.py'})
"                         call add(g:gutentags_project_info, {'type': 'ruby', 'file': 'Gemfile'})
"
"                         This means, for example, that you can use
"                         `g:gutentags_ctags_executable_ruby` out of the box.
"                         See |gutentags_ctags_executable_{filetype}| for more
"                         information.
"
"                                             *gutentags_file_list_command*
" g:gutentags_file_list_command
"                         Specifies command(s) to use to list files for which
"                         tags should be generated, instead of recursively
"                         examining all files within the project root. When
"                         invoked, file list commands will execute in the
"                         project root directory.
"
"                         This setting is useful in projects using source
"                         control to restrict tag generation to only files
"                         tracked in the repository.
"
"                         This variable may be set in one of two ways. If
"                         set as a |String|, the specified command will be used to
"                         list files for all projects. For example: >
"
"                          let g:gutentags_file_list_command = 'find . -type f'
" <
"                         If set as a |Dictionary|, this variable should be set
"                         as a mapping of project root markers to the desired
"                         file list command for that root marker. (See
"                         |gutentags_project_root| for how Gutentags uses root
"                         markers to locate the project.) For example: >
"
"                          let g:gutentags_file_list_command = {
"                              \ 'markers': {
"                                  \ '.git': 'git ls-files',
"                                  \ '.hg': 'hg files',
"                                  \ },
"                              \ }
" <
"                         Note: If a custom ctags executable is specified, it
"                         must support the '-L' command line option in order to
"                         read the list of files to be examined.
"
"
" The following settings are valid for the `ctags` module.
"
"                                                 *gutentags_ctags_executable*
" g:gutentags_ctags_executable
"                         Specifies the ctags executable to launch.
"                         Defaults to `ctags`.
"
"                                      *gutentags_ctags_executable_{filetype}*
" g:gutentags_ctags_executable_{type}
"                         Specifies the ctags executable to launch for a project
"                         of type {type}. See |gutentags_project_info| for more
"                         information.
"                         IMPORTANT: please see |gutentags-ctags-requirements|.
"                         Example: >
"                          let g:gutentags_ctags_executable_ruby = 'foobar'
" <
"
"                                                 *gutentags_ctags_tagfile*
" g:gutentags_ctags_tagfile
"                         Specifies the name of the tag file to create. This
"                         will be appended to the project's root. See
"                         |gutentags_project_root| for how Gutentags locates the
"                         project.
"                         Defaults to `tags`.
"
"                                                 *gutentags_ctags_exclude*
" g:gutentags_ctags_exclude
"                         A list of file patterns to pass to the
"                         |gutentags_ctags_executable| so that they will be
"                         excluded from parsing for the tags generation.
"                         See also |gutentags_ctags_exclude_wildignore|.
"                         Defaults to `[]` (an empty |List|).
"
"                                                 *gutentags_ctags_exclude_wildignore*
" g:gutentags_ctags_exclude_wildignore
"                         When 1, Gutentags will automatically pass your
"                         'wildignore' file patterns to the
"                         |gutentags_ctags_executable| so that they are ignored.
"                         Set also |gutentags_ctags_exclude| to pass custom
"                         patterns.
"                         Defaults to 1.
"
"                                                 *gutentags_ctags_auto_set_tags*
" g:gutentags_ctags_auto_set_tags
"                         If set to 1, Gutentags will automatically prepend
"                         'tags' with the exact path to the tag file for the
"                         current project. See |gutentags_project_root| for how
"                         Gutentags locates the project.
"                         When set to 0, Gutentags doesn't change 'tags', and
"                         this means that whatever tag file it generates may
"                         not be picked up by Vim. See |tagfiles()| to know what
"                         tag files Vim knows about.
"                         Defaults to 1.
"
"                                                 *gutentags_ctags_extra_args*
" g:gutentags_ctags_extra_args
"                         A list of arguments to pass to `ctags`.
"                         Defaults to `[]`.
" (I don't what following mean, but they seem good
let g:gutentags_ctags_extra_args = []
let g:gutentags_ctags_extra_args += ['--fields=+niazS']
let g:gutentags_ctags_extra_args += ['--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"
"                                                 *gutentags_ctags_post_process_cmd*
" g:gutentags_ctags_post_process_cmd
"                         If defined, the tags generation script will run the
"                         command with an argument that points to a temporary
"                         copy of the tags file. If the post-process step is
"                         modifying the tags file, it needs to do so in-place.
"                         This is useful for cleaning up a tags file that may
"                         contain tags with non-ASCII names that somehow upsets
"                         Vim.
"                         Defaults to `""` (an empty |String|).
"
"
" The following settings are valid for the `cscope` module.
"
"                                                 *gutentags_cscope_executable*
" g:gutentags_cscope_executable
"                         Specifies the name or path of the `cscope` executable
"                         to use to generate the code database.
"                         Defaults to `"cscope"`.
"
"                                                 *gutentags_scopefile*
" g:gutentags_scopefile
"                         Specifies the name of the scope file to create. This
"                         will be appended to the project's root. See
"                         |gutentags_project_root| for how Gutentags locates the
"                         project.
"                         Defaults to `"cscope.out"`.
"
"                                                 *gutentags_auto_add_cscope*
" g:gutentags_auto_add_cscope
"                         If set to 1, Gutentags will automatically add the
"                         generated code database to Vim by running `:cs add`
"                         (see |:cscope|).
"                         Defaults to 1.
"
"                                                 *gutentags_cscope_build_inverted_index*
" g:gutentags_cscope_build_inverted_index
"                         If set to 1, Gutentags will make `cscope` build an
"                         inverted index.
"                         Defaults to 0.
"
"
" The following settings are valid for the `gtags_cscope` module.
"
"                                                 *gutentags_gtags_executable*
" g:gutentags_gtags_executable
"                         Specifies the name or path of the `gtags` executable
"                         to use to generate the code database.
"                         Defaults to `"gtags"`.
"
"                                                 *gutentags_gtags_cscope_executable*
" g:gutentags_gtags_cscope_executable
"                         Specifies the name or path of the `gtags-cscope`
"                         executable to use to generate the code database.
"                         Defaults to `"gtags-cscope"`.
"
"                                                 *gutentags_gtags_dbpath*
" g:gutentags_gtags_dbpath
"                         Path from the cache directory (|gutentags_cache_dir|
"                         or project root) to the folder containing the
"                         definition database file (usually called `GTAGS`).
"                         Defaults to `""`.
"
"                                                 *gutentags_gtags_options_file*
" g:gutentags_gtags_options_file
"                         The name of a file that will be looked for in
"                         a project root directory. The file is expected to
"                         contain `gtags` options (one per line).
"                         Defaults to `".gutgtags"`.
"
"                                                 *gutentags_auto_add_gtags_cscope*
let g:gutentags_auto_add_gtags_cscope = 0
"                         If set to 1, Gutentags will automatically add the
"                         generated code database to Vim by running `:cs add`
"                         (see |:cscope|).
"                         Defaults to 1.










" " let $GTAGSLABEL = 'native-pygments'
" " pygment not working yet
" let $GTAGSLABEL = 'native'
" let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
"
" let g:gutentags_exclude_filetypes = ['vim']
"
" " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
" let g:gutentags_project_root = ['Makefile', '.git', '.root']
"
" " 所生成的数据文件的名称
" let g:gutentags_ctags_tagfile = '.tags'
"
" " 同时开启 ctags 和 gtags 支持：
" let g:gutentags_modules = []
" if executable('gtags-cscope') && executable('gtags')
"     let g:gutentags_modules += ['gtags_cscope']
" endif
" if executable('ctags')
"     let g:gutentags_modules += ['ctags']
" endif
"
" " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
" let g:gutentags_cache_dir = expand('~/.cache/nvim/tags')
"
" " 配置 ctags 的参数
" let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"
" " 如果使用 universal ctags 需要增加下面一行
" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags', '--recurse']
"
" " gutentags 自动加载 gtags 数据库
" let g:gutentags_auto_add_gtags_cscope = 1
"
" " :GutentagsToggleTrace
" let g:gutentags_define_advanced_commands = 1
"
" " focus to quickfix window after search
" let g:gutentags_plus_switch = 1
"
" " autocmd BufNew c,cpp,python :GscopeAdd
