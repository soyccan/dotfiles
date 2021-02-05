" Customize highlight behavior                             *EasyMotion_highlight*
"                                                    *g:EasyMotion_inc_highlight*
"
"     Using the 'n' key find motion (e.g. |<Plug>(easymotion-sn)|), EasyMotion
"     by default incrementally highlights matched text. If you don't want this
"     feature, set this option to 0
" >
"     let g:EasyMotion_inc_highlight = 0
" <
"     Default: 1
"
"                                                   *g:EasyMotion_move_highlight*
"
"     By default, when using |<Plug>(easymotion-next)| and/or
"     |<Plug>(easymotion-prev)|, EasyMotion highlights matched text until the
"     cursor moves, enters insert mode, or leaves the buffer. If you don't want
"     this feature, set this option to 0.
" >
"     let g:EasyMotion_move_highlight = 0
" <
"     Default: 1
"
"                                                *g:EasyMotion_landing_highlight*
"
"     If you want to keep highlights temporarily after EasyMotion
"     jumps to a destination (with timing set to
"     |g:EasyMotion_move_highlight|), set this option to 0.
" >
"     let g:EasyMotion_landing_highlight = 1
" <
"     Default: 0
"
" EasyMotion_add_search_history                 *g:EasyMotion_add_search_history*
"
"     If you set this option to 1, the 'n' key find motion will add the
"     inputted pattern to vim default search history. If you want to disable
"     this feature, set this value to 0.
" >
"     let g:EasyMotion_add_search_history = 0
" <
"     Default: 1
"
" EasyMotion_off_screen_search                   *g:EasyMotion_off_screen_search*
"
"     If you set this option to 1, the 'n' key find motion will search patterns
"     even outside the current screen range. If you want to disable this
"     feature, set this value to 0.
" >
"     let g:EasyMotion_off_screen_search = 0
" <
"     Default: 1
"
" EasyMotion_disable_two_key_combo           *g:EasyMotion_disable_two_key_combo*
"
"     If you set this option to 1, you can disable the two key combo feature.
" >
"     let g:EasyMotion_disable_two_key_combo = 1
" <
"     Default: 0
"
" EasyMotion_verbose                       *g:EasyMotion_verbose*
"
"     If you set this option to 0, you can disable all the messages the plugin
"     creates, such as "EasyMotion: Jumping to [l,c]" and "EasyMotion:
"     Cancelled".
" >
"     let g:EasyMotion_verbose = 0
" <
"     Default: 1
