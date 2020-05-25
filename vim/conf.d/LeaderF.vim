" Popup Mode
" ----------
"
" Popup Mode is to open LeaderF in a popup window(vim 8.1.1615+) or floating window(nvim 0.4.2+).
"
" To enable popup mode:
" ```vim
let g:Lf_WindowPosition = 'popup'
" ```
" or add `--popup` after each subcommand, e.g.,
" ```
" Leaderf file --popup
" ```
"
" It's better to set
" ```vim
let g:Lf_PreviewInPopup = 1
" ```
" , so that you can also preview the result in a popup window.
"
" Customization
" -------------
"
"  * Change key bindings
"
"     By default, `<Up>` and `<Down>` are used to recall last/next input
"     pattern from history. If you want to use them to navigate the result
"     list just like `<C-K>` and `<C-J>` :
"
" let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
"
"     for more detail, please refer to `:h g:Lf_CommandMap`.
"
"  * Change the colors used in LeaderF
"
"     ```vim
"     let g:Lf_PopupPalette = {
"         \  'light': {
"         \      'Lf_hl_match': {
"         \                'gui': 'NONE',
"         \                'font': 'NONE',
"         \                'guifg': 'NONE',
"         \                'guibg': '#303136',
"         \                'cterm': 'NONE',
"         \                'ctermfg': 'NONE',
"         \                'ctermbg': '236'
"         \              },
"         \      'Lf_hl_cursorline': {
"         \                'gui': 'NONE',
"         \                'font': 'NONE',
"         \                'guifg': 'NONE',
"         \                'guibg': '#303136',
"         \                'cterm': 'NONE',
"         \                'ctermfg': 'NONE',
"         \                'ctermbg': '236'
"         \              },
"         \      },
"         \  'dark': {
"         \         ...
"         \         ...
"         \      }
"         \  }
"     ```
"     All the highlight groups supported are defined in
"     [LeaderF/autoload/leaderf/colorscheme/popup/default.vim](https://github.com/Yggdroot/LeaderF/blob/master/autoload/leaderf/colorscheme/popup/default.vim).
"
"  * Change the default mapping of searching files command
"
"     e.g. `let g:Lf_ShortcutF = '<C-P>'`
"
"  * Show icons
"
"     Support commands: buffer,file,mru,window
"
"     ```vim
"     " Show icons, icons are shown by default
"     let g:Lf_ShowDevIcons = 1
"     " For GUI vim, the icon font can be specify like this, for example
"     let g:Lf_DevIconsFont = "DejaVuSansMono Nerd Font Mono"
"     " If needs
"     set ambiwidth=double
"     ```
"
"
" Configuration examples
" ----------------------
"
" ```vim
" " don't show the help in normal mode
" let g:Lf_HideHelp = 1
" let g:Lf_UseCache = 0
" let g:Lf_UseVersionControlTool = 0
" let g:Lf_IgnoreCurrentBufferName = 1
" " popup mode
" let g:Lf_WindowPosition = 'popup'
" let g:Lf_PreviewInPopup = 1
" let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
" let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
"
" let g:Lf_ShortcutF = "<leader>ff"
" noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
" noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
" noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
" noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
"
" noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
" noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" " search visually selected text literally
" xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
" noremap go :<C-U>Leaderf! rg --recall<CR>
"
" " should use `Leaderf gtags --update` first
" let g:Lf_GtagsAutoGenerate = 0
" let g:Lf_Gtagslabel = 'native-pygments'
" noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
" noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" ```
"

" g:leaderf_loaded                                *g:loaded_leaderf*
"     Whether leaderf plugin has been loaded.
"     Default value is 0.
"
" g:Lf_PythonVersion                              *g:Lf_PythonVersion*
"     Set this to 2 or 3 to specify the version of Python this plugin use.
"     If both python2 and python3 are supported, the default value is 3,
"     otherwise the default value is the supported version.
"
" g:Lf_ShortcutF                                  *g:Lf_ShortcutF*
"     Use this option to set the mapping of searching files command.
"     e.g. let g:Lf_ShortcutF = '<C-P>'
"     Default value is '<leader>f'.
"
" g:Lf_ShortcutB                                  *g:Lf_ShortcutB*
"     Use this option to set the mapping of searching buffers command.
"     Default value is '<leader>b'.
"
" g:Lf_WindowPosition                             *g:Lf_WindowPosition*
"     Setting this option can change the position of the LeaderF window.
"     The value can be 'fullScreen', 'top', 'bottom', 'left', 'right'.
"     'fullScreen' - the LeaderF window take up the full screen
"     'top' - the LeaderF window is at the top of the screen.
"     'bottom' - the LeaderF window is at the bottom of the screen.
"     'left' - the LeaderF window is at the left of the screen.
"     'right' - the LeaderF window is at the right of the screen.
"     'popup' - the LeaderF window is a popup window or floating window.
"     Default value is 'bottom'.
"
" g:Lf_WindowHeight                               *g:Lf_WindowHeight*
"     This option is used to set the default height of the LeaderF window.
"     If the value is a floating point number less than 1, it means the
"     percentage of the height of the vim window.
"     e.g., let g:Lf_WindowHeight = 0.30
"     The option will be ignored if the value of |g:Lf_WindowPosition| is
"     not 'top' or 'bottom'.
"     Default value is 0.5.
"
" g:Lf_TabpagePosition                            *g:Lf_TabpagePosition*
"     Specify where to put the newly opened tab page.
"     The value can be 0, 1, 2, ...
"     0 - make the newly opened tab page the first one.
"     1 - put the newly opened tab page before the current one.
"     2 - put the newly opened tab page after the current one.
"     3 - make the newly opened tab page the last one.
"     Default value is 2.
"
" g:Lf_ShowRelativePath                           *g:Lf_ShowRelativePath*
"     Whether to show the relative path in the LeaderF window.
"     0 - no
"     1 - yes
"     Default value is 1.
"
" g:Lf_DefaultMode                                *g:Lf_DefaultMode*
"     Specify the default mode when LeaderF is launched.
"     There are 4 modes, and the corresponding values are:
"     'NameOnly' - fuzzy mode, match file name only when searching
"     'FullPath' - fuzzy mode, match full path when searching
"     'Fuzzy' - fuzzy mode, when lines in the result are not file path
"     'Regex' - regex mode
"     Default value is 'FullPath'
"
" g:Lf_CursorBlink                                *g:Lf_CursorBlink*
"     Set this option to 1 to let the cursor in the prompt blink, if you don't
"     want the cursor to blink, set the value to 0.
"
" g:Lf_CacheDirectory                              *g:Lf_CacheDirectory*
"     Set this option to change the location of the cache directory.
"     e.g. >
"     let g:Lf_CacheDirectory = '/root'
" <
"     Default value is $HOME.
"
" g:Lf_NeedCacheTime                              *g:Lf_NeedCacheTime*
"     This option set a threshold, if the time of indexing files is greater than
"     the threshold, cache the files list.
"     Default value is 1.5 seconds.
"
" g:Lf_NumberOfCache                              *g:Lf_NumberOfCache*
"     This option specifies the number of cache.
"     Default value is 5.
"
" g:Lf_UseMemoryCache                             *g:Lf_UseMemoryCache*
"     Whether to use the memory to cache the indexing result.
"     0 - no
"     1 - yes
"     Default value is 1.
"
" g:Lf_IndexTimeLimit                             *g:Lf_IndexTimeLimit*
"     Specify the maximum time of indexing the files that you can tolerate to
"     wait.
"     Default value is 120 seconds.
"
" g:Lf_FollowLinks                                *g:Lf_FollowLinks*
"     Whether to visit directories pointed to by symlinks when indexing.
"     0 - no
"     1 - yes
"     Default value is 0.
"
" g:Lf_WildIgnore                                 *g:Lf_WildIgnore*
"     Specify the files and directories you want to exclude while indexing.
"     Default value is: >
"     let g:Lf_WildIgnore = {
"             \ 'dir': [],
"             \ 'file': []
"             \}
" <
"     Here uses the Unix shell-style wildcards, which are not the same as
"     regular expressions. The special characters used in shell-style wildcards
"     are: >
"     Pattern  |          Meaning
"     -------------------------------------------
"     *        | matches everything
"     ?        | matches any single character
"     [seq]    | matches any character in seq
"     [!seq]   | matches any character not in seq
"     -------------------------------------------
" <
"     For example, you can set as below: >
"     let g:Lf_WildIgnore = {
"             \ 'dir': ['.svn','.git','.hg'],
"             \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
"             \}
" <
" g:Lf_DelimiterChar                              *g:Lf_DelimiterChar*
"     In NameOnly mode, if you want to refine the result by typing extra
"     characters to match the directory, type this character first.
"     Default value is ';'.
"
" g:Lf_MruFileExclude                             *g:Lf_MruFileExclude*
"     Files you don't want LeaderF to record.
"     See |g:Lf_WildIgnore| for the usage of pattern.
"     e.g. >
"     let g:Lf_MruFileExclude = ['*.so']
" <
"     Default value is [].
"
" g:Lf_MruMaxFiles                                *g:Lf_MruMaxFiles*
"     Specify the number of most recently used files you want LeaderF to record.
"     Default value is 100.
"
" g:Lf_HighlightIndividual                        *g:Lf_HighlightIndividual*
"     Whether to highlight individual character of the input in the result.
"     Set the value to 0 to highlight consecutive characters.
"     Default value is 1.
"
" g:Lf_NumberOfHighlight                          *g:Lf_NumberOfHighlight*
"     Specify the number of highlight lines in the result.
"     Default value is 100.
"
" g:Lf_StlColorscheme                             *g:Lf_StlColorscheme*
"     You can configure the colorscheme of statusline for LeaderF.
"     e.g. >
"     let g:Lf_StlColorscheme = 'powerline'
" <
"     The colorscheme files can be found in the directory >
"     "LeaderF/autoload/leaderf/colorscheme/"
" <
"     Default value is 'default'.
"
" g:Lf_StlSeparator                               *g:Lf_StlSeparator*
"     A Dictionary to store separators.
"     The default value is >
"     let g:Lf_StlSeparator = { 'left': '►', 'right': '◄', 'font': '' }
" <
"     If you don't like using separators, you can set the value as below: >
"     let g:Lf_StlSeparator = { 'left': '', 'right': '' }
" <
"     You can also use the patched font you used for |vim-powerline| and |powerline|.
"
"     The patched fonts for |powerline| are available at
"     https://github.com/Lokaltog/powerline-fonts
"
"     A tutorial to create a patched font for |vim-powerline| is available at
"     https://github.com/Lokaltog/vim-powerline/tree/develop/fontpatcher
"
"     If you have installed the patched font for |powerline|, following setting looks
"     nice. >
"     let g:Lf_StlSeparator = { 'left': '', 'right': '' }
" <
"     If you have installed the patched font for |vim-powerline|, following setting
"     looks nice. >
"     let g:Lf_StlSeparator = { 'left': '⮀', 'right': '⮂' }
" <
"     If the statusline does not correctly show the special characters, use the
"     unicode numbers.
"     For |powerline| font users: >
"     let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
" <
"     For |vim-powerline| font users: >
"     let g:Lf_StlSeparator = { 'left': "\u2b80", 'right': "\u2b82" }
" <
"     If you haven't set the global option |guifont|, you can still use the patched
"     fonts, e.g., >
"     let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
" <
" g:Lf_StlPalette                                 *g:Lf_StlPalette*
"     This is a dictionary, you can customize the colorscheme using this option.
"     Default colorscheme is equivalent to the following setting: >
"     let g:Lf_StlPalette = {
"             \   'stlName': {
"             \       'gui': 'bold',
"             \       'font': 'NONE',
"             \       'guifg': '#2F5C00',
"             \       'guibg': '#BAFFA3',
"             \       'cterm': 'bold',
"             \       'ctermfg': '22',
"             \       'ctermbg': '157'
"             \   },
"             \   'stlCategory': {
"             \       'gui': 'NONE',
"             \       'font': 'NONE',
"             \       'guifg': '#000000',
"             \       'guibg': '#F28379',
"             \       'cterm': 'NONE',
"             \       'ctermfg': '16',
"             \       'ctermbg': '210'
"             \   },
"             \   'stlNameOnlyMode': {
"             \       'gui': 'NONE',
"             \       'font': 'NONE',
"             \       'guifg': '#000000',
"             \       'guibg': '#E8ED51',
"             \       'cterm': 'NONE',
"             \       'ctermfg': '16',
"             \       'ctermbg': '227'
"             \   },
"             \   'stlFullPathMode': {
"             \       'gui': 'NONE',
"             \       'font': 'NONE',
"             \       'guifg': '#000000',
"             \       'guibg': '#AAAAFF',
"             \       'cterm': 'NONE',
"             \       'ctermfg': '16',
"             \       'ctermbg': '147'
"             \   },
"             \   'stlFuzzyMode': {
"             \       'gui': 'NONE',
"             \       'font': 'NONE',
"             \       'guifg': '#000000',
"             \       'guibg': '#E8ED51',
"             \       'cterm': 'NONE',
"             \       'ctermfg': '16',
"             \       'ctermbg': '227'
"             \   },
"             \   'stlRegexMode': {
"             \       'gui': 'NONE',
"             \       'font': 'NONE',
"             \       'guifg': '#000000',
"             \       'guibg': '#7FECAD',
"             \       'cterm': 'NONE',
"             \       'ctermfg': '16',
"             \       'ctermbg': '121'
"             \   },
"             \   'stlCwd': {
"             \       'gui': 'NONE',
"             \       'font': 'NONE',
"             \       'guifg': '#EBFFEF',
"             \       'guibg': '#606168',
"             \       'cterm': 'NONE',
"             \       'ctermfg': '195',
"             \       'ctermbg': '241'
"             \   },
"             \   'stlBlank': {
"             \       'gui': 'NONE',
"             \       'font': 'NONE',
"             \       'guifg': 'NONE',
"             \       'guibg': '#3B3E4C',
"             \       'cterm': 'NONE',
"             \       'ctermfg': 'NONE',
"             \       'ctermbg': '237'
"             \   },
"             \   'stlLineInfo': {
"             \       'gui': 'NONE',
"             \       'font': 'NONE',
"             \       'guifg': '#000000',
"             \       'guibg': '#EBFFEF',
"             \       'cterm': 'NONE',
"             \       'ctermfg': '16',
"             \       'ctermbg': '195'
"             \   },
"             \   'stlTotal': {
"             \       'gui': 'NONE',
"             \       'font': 'NONE',
"             \       'guifg': '#000000',
"             \       'guibg': '#BCDC5C',
"             \       'cterm': 'NONE',
"             \       'ctermfg': '16',
"             \       'ctermbg': '149'
"             \   }
"             \ }
" <
"     For example, if you want to change the color of 'stlName', you can configure
"     like this: >
"     let g:Lf_StlPalette.stlName = {
"             \       'gui': 'bold',
"             \       'font': 'NONE',
"             \       'guifg': '#2F5C00',
"             \       'guibg': '#BAFFA3',
"             \       'cterm': 'bold',
"             \       'ctermfg': '22',
"             \       'ctermbg': '157'
"             \ }
" <
"     or just change the color of GUI: >
"     let g:Lf_StlPalette.stlName = {
"             \       'gui': 'bold',
"             \       'font': 'NONE',
"             \       'guifg': '#2F5C00',
"             \       'guibg': '#BAFFA3'
"             \ }
" <
" g:Lf_Ctags                                      *g:Lf_Ctags*
"     Use this option to specify the ctags executable you use. If ctags is not
"     in one of the directories in your $PATH environment variable, you should
"     set it by yourself. e.g., >
"     let g:Lf_Ctags = "/usr/local/universal-ctags/ctags"
" <
"     Default value is "ctags".
"
" g:Lf_CtagsFuncOpts                              *g:Lf_CtagsFuncOpts*
"     Use this option to specify the options of ctags to generate the tags of
"     functions. e.g., >
"     let g:Lf_CtagsFuncOpts = {
"             \ 'c': '--c-kinds=fp',
"             \ 'rust': '--rust-kinds=f',
"             \ }
" <
" g:Lf_PreviewCode                                *g:Lf_PreviewCode*
"     Use this option to specify whether to show the preview of the code the tag
"     locates in when navigating the tags.
"
"     Default value is 0.
"
" g:Lf_DefaultExternalTool                        *g:Lf_DefaultExternalTool*
"     Use this option to specify the default external tool which is used to
"     index the files. Possible values are 'rg', 'pt'(not available on Windows),
"     'ag'(not available on Windows), 'find'.  If you do not want to use the external tool: >
"     let g:Lf_DefaultExternalTool = ""
" <
"     By default, use the external tool in the sequence of 'rg', 'pt', 'ag', 'find'
"     if one is available. If none of the tools are available, falls back to the
"     build-in python implementation which is a little slower.
"
" g:Lf_UseVersionControlTool                      *g:Lf_UseVersionControlTool*
"     This option specifies whether to use version control tool to index the
"     files when inside a repository under control. If not a version control
"     repository or value is 0, falls back to |g:Lf_DefaultExternalTool|.
"     e.g.
"     use command `git ls-files` for git repository;
"     use command `hg files` for hg repository.
"     Note: |g:Lf_WildIgnore| is ignored when using these commands.
"
"     Default value is 1.
"
" g:Lf_ExternalCommand                            *g:Lf_ExternalCommand*
"     Use this option to specify a external command to index the files. If not
"     specified, falls back to |g:Lf_UseVersionControlTool|.
"
"     Use "%s"(quotes are necessary for directory name with space in it) as the
"     placeholder of the start directory.
"     e.g. >
"     let g:Lf_ExternalCommand = 'dir "%s" /s/b/a-d-h-s'       " On Windows
"     let g:Lf_ExternalCommand = 'find "%s" -type f'           " On MacOSX/Linux
" <
"     Note: |g:Lf_UseVersionControlTool| and |g:Lf_DefaultExternalTool| are
"     ignored if this option is specified.
"
" g:Lf_PreviewResult                              *g:Lf_PreviewResult*
"     This is a dictionary, indicates whether to enable the preview of the result.
"     Default value is: >
"     let g:Lf_PreviewResult = {
"             \ 'File': 0,
"             \ 'Buffer': 0,
"             \ 'Mru': 0,
"             \ 'Tag': 0,
"             \ 'BufTag': 1,
"             \ 'Function': 1,
"             \ 'Line': 0,
"             \ 'Colorscheme': 0,
"             \ 'Rg': 0,
"             \ 'Gtags': 0
"             \}
" <
"     e.g., if you want to disable the preview of BufTag explorer: >
"     let g:Lf_PreviewResult = { 'BufTag': 0 }
" <
" g:Lf_RememberLastSearch                         *g:Lf_RememberLastSearch*
"     This option specifies whether to remember the last search. If the value is
"     1, the search string you typed during last search is still there when
"     LeaderF is launched again. (Introduced in issue #62)
"
"     Default value is 0.
"
" g:Lf_UseCache                                   *g:Lf_UseCache*
"     This option specifies whether to cache the files list. If the value is 1,
"     LeaderF won't reindex the files when reopen vim.(Introduced in issue #64)
"
"     Default value is 1.
"
" g:Lf_NormalMap                                  *g:Lf_NormalMap*
"     Use this option to customize the mappings in normal mode.
"     The mapping with the key `"_"` applies to all categories.
"     Also, `"_"` is overridden by the mapping of each category.
"     e.g., >
"     let g:Lf_NormalMap = {
"         \ "_":      [["<C-j>", "j"],
"         \            ["<C-k>", "k"]
"         \           ],
"         \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>'],
"         \            ["<F6>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']
"         \           ],
"         \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>'],
"         \            ["<F6>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']
"         \           ],
"         \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
"         \ "Tag":    [],
"         \ "BufTag": [],
"         \ "Function": [],
"         \ "Line":   [],
"         \ "History":[],
"         \ "Help":   [],
"         \ "Self":   [],
"         \ "Colorscheme": []
"         \}
" <
" g:Lf_RootMarkers                                *g:Lf_RootMarkers*
"     Use this option to set the root markers.
"     e.g., >
"     let g:Lf_RootMarkers = ['.project', '.project2']
" <
"     Default value is ['.git', '.hg', '.svn']
"
" g:Lf_WorkingDirectoryMode                       *g:Lf_WorkingDirectoryMode*
"     This option customizes LeaderF's working directory.
"     e.g., >
"     let g:Lf_WorkingDirectoryMode = 'Ac'
" <
"     c - the directory of the current working directory.(default)
"     a - the nearest ancestor of current working directory that contains one of
"         directories or files defined in |g:Lf_RootMarkers|. Fall back to 'c' if
"         no such ancestor directory found.
"     A - the nearest ancestor of current file that contains one of directories
"         or files defined in |g:Lf_RootMarkers|. Fall back to 'c' if no such
"         ancestor directory found.
"     f - the directory of the current file.
"     F - if the current working directory is not the direct ancestor of current
"         file, use the directory of the current file as LeaderF's working
"         directory, otherwise, same as 'c'.
"     Note: if "f", "F" is included with "a" or "A", use the behavior of "f" or
"     "F"(as a fallback) when a root can't be found.
" let g:Lf_WorkingDirectoryMode = 'A'
"
" g:Lf_WorkingDirectory                           *g:Lf_WorkingDirectory*
"     Set LeaderF's working directory. It will ignore the |g:Lf_RootMarkers| and
"     |g:Lf_WorkingDirectoryMode| option set.
"     e.g., >
"     let g:Lf_WorkingDirectory = finddir('.git', '.;')
" let g:Lf_WorkingDirectory = projectroot#get()
" <
" g:Lf_CommandMap                                 *g:Lf_CommandMap*
"     Use this option to customize the mappings inside LeaderF's
"     prompt(|leaderf-prompt|).
"     for example, if you want to change the default command <C-F> to <C-D> and
"     change the default command <ESC> to <C-A> and <C-B>: >
"     let g:Lf_CommandMap = {'<C-F>': ['<C-D>'], '<ESC>': ['<C-A>', '<C-B>']}
" <
" g:Lf_HideHelp                                   *g:Lf_HideHelp*
"     To specify whether to show the hint "Press <F1> for help" in normal mode.
"     You can set the value to 1 to hide the hint.
"     Default value is 0.
"
" g:Lf_ShowHidden                                 *g:Lf_ShowHidden*
"     To Specify whether to search hidden files and directories.
"     Default value is 0.(do not search hidden files and directories)
"
" g:Lf_MruWildIgnore                              *g:Lf_MruWildIgnore*
"     This option indicates that do not display the MRU files whose file name
"     matches the patterns defined in it.
"     See |g:Lf_WildIgnore| for the usage of pattern.
"
"     Default value is: >
"     let g:Lf_MruWildIgnore = {
"             \ 'dir': [],
"             \ 'file': []
"             \}
" <
" g:Lf_RecurseSubmodules                          *g:Lf_RecurseSubmodules*
"     This option indicates whether to show the files in submodules of git
"     repository. If the value is 1, it means git command has '--recurse-submodules'
"     option. Because '--recurse-submodules' was first introduced by git version
"     2.11+ and there will be an error if git version is lower than 2.11, this
"     option is off with value 0 by default.
"
" g:Lf_ReverseOrder                               *g:Lf_ReverseOrder*
"     Show results in bottom-up order.
"     Default value is 0(top-down order).
"
" g:Lf_AndDelimiter                               *g:Lf_AndDelimiter*
"     The And operator character, default value is ' '(space).
"
" g:Lf_HistoryNumber                              *g:Lf_HistoryNumber*
"     Specify the number of records in history.
"     Default value is 100.
"
" g:Lf_HistoryExclude                              *g:Lf_HistoryExclude*
"     This option indicates that do not display the historires that matches the
"     patterns defined in it.
"
"     Default value is: >
"     let g:Lf_HistoryExclude = {
"             \ 'cmd': [],
"             \ 'search': []
"             \}
" <
"     This is specified with a Python regular expression.
"
"     For example, you can set as below: >
"     let g:Lf_HistoryExclude = {
"             \ 'cmd': ['^w!?', '^q!?', '^.\s*$'],
"             \ 'search': ['^Plug']
"             \}
" <
" g:Lf_HistoryEditPromptIfEmpty                   *g:Lf_HistoryEditPromptIfEmpty*
"     This option is used when the history (cmdHistory or searchHistory).
"     If set to 1, when editing is started when there are 0 results, the text of
"     the entered prompt is edited.
"     Default value is 1.
"
" g:Lf_RgConfig                                   *g:Lf_RgConfig*
"     Specify a list of ripgrep configurations. For example, >
"     let g:Lf_RgConfig = [
"         \ "--max-columns=150",
"         \ "--type-add web:*.{html,css,js}*",
"         \ "--glob=!git/*",
"         \ "--hidden"
"     \ ]
" <
"     Default value is [].
"
" g:Lf_RgStorePattern                             *g:Lf_RgStorePattern*
"     Specify the register to store the search pattern when you exit LeaderF.
"     The pattern entered with `-e` of the `Leaderf rg` command is stored. Also,
"     patterns are converted to Vim's regexp.
"
"     For example, When there is one pattern:
"         When executed in `Leaderf rg -e "pat1"`, `/\v\cpat1` is stored.
"
"     For example, When there are multiple patterns:
"         If multiple patterns are specified, they will be joined with `|`.
"         When executed in `Leaderf rg -e "pat1" -e "pat2"`, `/\v\cpat1|pat2` is
"         stored.
"
"     Default value is "".
"
" g:Lf_MaxCount                                   *g:Lf_MaxCount*
"     Specify the limit of the number of source entries. LeaderF will stop
"     producing the source entries if the limit is hit. There is no limit if the
"     value is less than 1(<=0).
"     Default value is 2000000.
"
" g:Lf_NoChdir                                    *g:Lf_NoChdir*
"     Don't change the current working directory when using `LeaderfFile dir` if
"     the value is 1, otherwise the current working directory will be changed
"     to `dir`.
"     Default value is 1.
"
" g:Lf_GtagsAutoGenerate                          *g:Lf_GtagsAutoGenerate*
"     If the value is 1 and there is a rootmark defined by |g:Lf_RootMarkers|
"     under the project root directory, gtags files will be generated
"     automatically the first time when starting to edit a new buffer, after
"     reading the file into the buffer. Otherwise, gtags files should be
"     generated manually by using `Leaderf gtags --update` .
"     Default value is 0.
"
" g:Lf_GtagsSource                                *g:Lf_GtagsSource*
"     Gtags accepts a list of files as target files. This option indicates
"     where the target files come from. It has 3 values: 0, 1, 2.
"     0 - gtags search the target files by itself.
"     1 - the target files come from FileExplorer.
"     2 - the target files come from |g:Lf_GtagsfilesCmd|.
"     Default value is 0.
"
" g:Lf_GtagsfilesCmd                              *g:Lf_GtagsfilesCmd*
"     If |g:Lf_GtagsSource| is 2, use the command defined by this option to
"     generate the target files.
"     Default value is: >
"     let g:Lf_GtagsfilesCmd = {
"             \ '.git': 'git ls-files --recurse-submodules',
"             \ '.hg': 'hg files',
"             \ 'default': 'rg --no-messages --files'
"             \}
" <
"     , which means use command `git ls-files --recurse-submodules` for git
"     repository and `hg files` for hg repository, use `rg --no-messages --files`
"     otherwise.
"
" g:Lf_GtagsAcceptDotfiles                          *g:Lf_GtagsAcceptDotfiles*
"     This option tells gtags to accept files and directories whose names begin
"     with a dot if the value is 1.
"     Default value is 0.
"
" g:Lf_GtagsSkipUnreadable                          *g:Lf_GtagsSkipUnreadable*
"     This option tells gtags to skip unreadable files if the value is 1.
"     Default value is 0.
"
" g:Lf_GtagsSkipSymlink                             *g:Lf_GtagsSkipSymlink*
"     This option tells gtags to skip symbolic links. If value is 'f' then skip
"     only symbolic links for file, else if 'd' then skip only symbolic links
"     for directory, else if value is 'a' then all symbolic links are skipped.
"     Default value is "".
"
" g:Lf_Gtagsconf                                    *g:Lf_Gtagsconf*
"     This option specifies the path of gtags configuration file('gtags.conf' or
"     '.globalrc').
"     Basically, you don't have to use this option, gtags has default values in
"     itself. If you have the file as '/etc/gtags.conf' or "$HOME/.globalrc",
"     gtags will overwrite the default values with values in the file.
"
"     Default value is "".
"
" g:Lf_Gtagslabel                                   *g:Lf_Gtagslabel*
"     This option specifies a label of the configuration file.
"     By default, gtags supports C, C++, Yacc, Java, PHP and Assembly
"     programming language. If you want to support other programming languages,
"     you can install the pygments package by command `pip install pygments` and
"     set this option as "native-pygments".
"     Default value is "default".
"
" g:Lf_GtagsStoreInProject                          *g:Lf_GtagsStoreInProject*
"     This option specifies whether to store the gtags database files in the
"     root directory of the project.
"
"     Default value is 0.
"
" g:Lf_EmptyQuery                                   *g:Lf_EmptyQuery*
"     This option specifies whether to enable the empty query, i.e., if no
"     pattern is input, sort the result according to the best match of current
"     buffer's name.
"
"     Default value is 1.
"
" g:Lf_IgnoreCurrentBufferName                      *g:Lf_IgnoreCurrentBufferName*
"     This option specifies whether to remove the current buffer name from
"     the result list.
"
"     Default value is 0.
"
" g:Lf_PreviewInPopup                               *g:Lf_PreviewInPopup*
"     This option specifies whether to preview the result in a popup window.
"
"     Default value is 0.
"
" g:Lf_PreviewHorizontalPosition                    *g:Lf_PreviewHorizontalPosition*
"     Specify where to locate the preview window horizontally. The value can be
"     one of the following:
"     'left': the preview window is on the left side of the screen.
"     'center': the preview window is in the center of the screen.
"     'right': the preview window is on the right side of the screen.
"     'cursor': the preview window is at the cursor position.
"
"     Default value is 'cursor'.
"
" g:Lf_PreviewPopupWidth                            *g:Lf_PreviewPopupWidth*
"     Specify the width of preview popup window, the value should be a non-negative
"     integer. If the value is 0, the width is half of the screen's width.
"
"     Default value is 0.
"
" g:Lf_DiscardEmptyBuffer                           *g:Lf_DiscardEmptyBuffer*
"     Specify whether to discard the first empty [No Name] buffer when opening
"     with <C-T>.
"
"     Default value is 0.
"
" g:Lf_PopupWidth                                   *g:Lf_PopupWidth*
"     Specify the width of the popup window or floating window when LeaderF is
"     in popup mode. `Popup mode` is when |g:Lf_WindowPosition| is 'popup' or '--popup'
"     is in the options list of `Leaderf` command.
"     The value is a non-negative integer. If the value is 0, the width is 2/3 of
"     vim's width.
"
"     If the value is a floating point number less than 1, it means the percentage
"     of the width of the vim window.
"
"     For example, set the width to 3/4 of the screen's width: >
"     let g:Lf_PopupWidth = &columns * 3 / 4
"     or
"     let g:Lf_PopupHeight = 0.75
" <
"     Default value is 0.
"
" g:Lf_PopupHeight                                   *g:Lf_PopupHeight*
"     Specify the height of the popup window or floating window when LeaderF is
"     in popup mode. `Popup mode` is when |g:Lf_WindowPosition| is 'popup' or '--popup'
"     is in the options list of `Leaderf` command.
"     The value is a non-negative integer. If the value is 0, the height is 40% of
"     vim's height.
"     If the value is a floating point number less than 1, it means the percentage
"     of the height of the vim window.
"
"     For example, set the height to 30% of the vim's height: >
"     let g:Lf_PopupHeight = float2nr(&lines * 0.3)
"     or
"     let g:Lf_PopupHeight = 0.3
" <
"     Default value is 0.
"
" g:Lf_PopupPosition                                 *g:Lf_PopupPosition*
"     Specify the coordinate of the topleft corner of popup window or floating
"     window when LeaderF is in popup mode. `Popup mode` is when |g:Lf_WindowPosition|
"     is 'popup' or '--popup' is in the options list of `Leaderf` command.
"     The value is a list [`line`, `col`], the first line and the first column are
"     both 1.
"     If the value of `line` is 0, the popup window or floating window is vertically
"     centered.
"     If the value of `col` is 0, the popup window or floating window is horizontally
"     centered.
"
"     Default value is [0, 0].
"
" g:Lf_PopupShowStatusline                           *g:Lf_PopupShowStatusline*
"     Specify whether to show the statusline when LeaderF is in popup mode.
"     `Popup mode` is when |g:Lf_WindowPosition| is 'popup' or '--popup' is in the
"     options list of `Leaderf` command.
"
"     Default value is 1.
"
" g:Lf_PopupPreviewPosition                          *g:Lf_PopupPreviewPosition*
"     Specify where to locate the preview window when LeaderF is in popup mode.
"     `Popup mode` is when |g:Lf_WindowPosition| is 'popup' or '--popup' is in the
"     options list of `Leaderf` command.
"     The value can be one of the following:
"     'top': the preview window is on the top of the main LeaderF window.
"     'bottom': the preview window is at the bottom of the main LeaderF window.
"     'cursor': the preview window is at the cursor position in the main LeaderF
"               window.
"
"     Default value is 'top'.
"
" g:Lf_PopupColorscheme                              *g:Lf_PopupColorscheme*
"     You can configure the colorscheme of LeaderF in popup mode.
"     e.g. >
"     let g:Lf_PopupColorscheme = 'default'
" <
"     The colorscheme files can be found in the directory >
"     "LeaderF/autoload/leaderf/colorscheme/popup/"
" <
"     You can also define the colorscheme by yourself, follow 'default.vim' and
"     put it under "autoload/leaderf/colorscheme/popup/".
"
"     Default value is 'default'.
"
" g:Lf_PopupPalette                                  *g:Lf_PopupPalette*
"     This is a dictionary, you can customize the colorscheme of popup mode using
"     it.
"     Its structure is like below: >
"     let g:Lf_PopupPalette = {
"         \  'light': {
"         \      'Lf_hl_match': {
"         \                'gui': 'NONE',
"         \                'font': 'NONE',
"         \                'guifg': 'NONE',
"         \                'guibg': '#303136',
"         \                'cterm': 'NONE',
"         \                'ctermfg': 'NONE',
"         \                'ctermbg': '236'
"         \              },
"         \      'Lf_hl_cursorline': {
"         \                'gui': 'NONE',
"         \                'font': 'NONE',
"         \                'guifg': 'NONE',
"         \                'guibg': '#303136',
"         \                'cterm': 'NONE',
"         \                'ctermfg': 'NONE',
"         \                'ctermbg': '236'
"         \              },
"         \      },
"         \  'dark': {
"         \         ...
"         \         ...
"         \      }
"         \  }
" <
"     All the highlight groups supported are defined in
"     `LeaderF/autoload/leaderf/colorscheme/popup/default.vim`
"
"     It is not defined by default.
"
" g:Lf_AutoResize                                 *g:Lf_AutoResize*
"     Auto resize the LeaderF window height automatically.
"
"     Default value is 0.
"
" g:Lf_JumpToExistingWindow                       *g:Lf_JumpToExistingWindow*
"     Jump to existing window if the selected file is already opened in a
"     window.
"
"     Default value is 0.
"
" g:Lf_ShowDevIcons                               *g:Lf_ShowDevIcons*
"     Support commands: buffer,file,mru,window
"
"     Default value is 1.
"
" g:Lf_DevIconsFont                                 *g:Lf_DevIconsFont*
"     Specifies the font used to display the icon.
"     If it is empty, use the default font.
"
"     Also, the value of |g:Lf_DevIconsPalette| takes precedence.
"
"     Default value is `''`.
"
" g:Lf_DevIconsPalette                            *g:Lf_DevIconsPalette*
"     This is a dictionary with customizable icons highlights.
"
"     Its structure is like below: >
"     let g:Lf_DevIconsPalette = {
"         \  'light': {
"         \      '_': {
"         \                'gui': 'NONE',
"         \                'font': 'NONE',
"         \                'guifg': '#505050',
"         \                'guibg': 'NONE',
"         \                'cterm': 'NONE',
"         \                'ctermfg': '238',
"         \                'ctermbg': 'NONE'
"         \              },
"         \      'default': {
"         \                'guifg': '#505050',
"         \                'ctermfg': '238',
"         \              },
"         \      },
"         \      'vim': {
"         \                'guifg': '#007F00',
"         \                'ctermfg': '28',
"         \              },
"         \      },
"         \      '.gitignore': {
"         \                'guifg': '#dd4c35',
"         \                'ctermfg': '166',
"         \              },
"         \      },
"         \  'dark': {
"         \         ...
"         \         ...
"         \      }
"         \  }
" <
"     Key Description:
"         `'_'` :       All icons with no customized highlights.
"         `'default'` : General Icons.
"         Other Keys: Icons of the file type and the specified file name.
"
"     The default values can be seen in a dict called `devicons_palette` in
"     `LeaderF/autoload/leaderf/python/leaderf/devicons.py`
"
"     The default value is set by referring to
"     https://github.com/vscode-icons/vscode-icons
"
" g:Lf_DevIconsExactSymbols                       *g:Lf_DevIconsExactSymbols*
"     Dictionary mappings for exact file node matches
"
"     e.g.: >
"     let g:Lf_DevIconsExactSymbols = { 'tags': '󿧸' }
" <
"     Default value is `{}`
"
" g:Lf_DevIconsExtensionSymbols                   *g:Lf_DevIconsExtensionSymbols*
"     Dictionary mappings for file extension matches
"
"     e.g.: >
"     let g:Lf_DevIconsExtensionSymbols = { 'tmp': '󿦨' }
" <
"     Default value is `{}`
"
" g:Lf_SpinSymbols                                *g:Lf_SpinSymbols*
"     Specify a list of spin symbols at the top right corner.
"
"     For Linux platform, the default value is ['△', '▲', '▷', '▶', '▽', '▼', '◁', '◀'],
"     for Windows and MacOS, the default value is ['🌘', '🌗', '🌖', '🌕', '🌔', '🌓', '🌒', '🌑']
"
"


" let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
"
" let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git', 'Makefile']
" let g:Lf_WorkingDirectoryMode = 'Ac'
" let g:Lf_WindowHeight = 0.30
" let g:Lf_CacheDirectory = expand('~/.cache/nvim')
" let g:Lf_ShowRelativePath = 0
" let g:Lf_HideHelp = 1
" let g:Lf_StlColorscheme = 'powerline'
" let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
