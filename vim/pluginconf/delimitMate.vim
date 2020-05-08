"  3. FUNCTIONALITY                                   *delimitMateFunctionality*
"
" ------------------------------------------------------------------------------
"    3.1 AUTOMATIC CLOSING AND EXITING                    *delimitMateAutoClose*
"
" With automatic closing enabled, if an opening delimiter is inserted the plugin
" inserts the closing delimiter and places the cursor between the pair. With
" automatic closing disabled, no closing delimiters is inserted by delimitMate,
" but when a pair of delimiters is typed, the cursor is placed in the middle.
"
" When the cursor is inside an empty pair or located next to the left of a
" closing delimiter, the cursor is placed outside the pair to the right of the
" closing delimiter.
"
" When |'delimitMate_smart_matchpairs'| is not empty and it matches the text to
" the right of the cursor, delimitMate will not automatically insert the closing
" pair.
"
" Unless |'delimitMate_matchpairs'| or |'delimitMate_quotes'| are set, this
" script uses the values in '&matchpairs' to identify the pairs, and ", ' and `
" for quotes respectively.
"
" <S-Tab> will jump over a single closing delimiter or quote, <C-G>g will jump
" over contiguous delimiters and/or quotes.
"
" The following table shows the behaviour, this applies to quotes too (the final
" position of the cursor is represented by a "|"):
"
" With auto-close: >
"                           Type     |  You get
"                         =======================
"                            (       |    (|)
"                         -----------|-----------
"                            ()      |    ()|
"                         -----------|-----------
"                         (<S-Tab>   |    ()|
"                         -----------|-----------
"                         {("<C-G>g  |  {("")}|
" <
" Without auto-close: >
"
"                           Type        |  You get
"                         =========================
"                            ()         |    (|)
"                         --------------|----------
"                            ())        |    ()|
"                         --------------|----------
"                         ()<S-Tab>     |    ()|
"                         --------------|----------
"                         {}()""<C-G>g  |  {("")}|
" <
" NOTE: Abbreviations will not be expanded by delimiters used on delimitMate,
" you should use <C-]> (read |i_CTRL-]|) to expand them on the go.
"
let g:delimitMate_autoclose = 1
" ------------------------------------------------------------------------------
"    3.2 EXPANSION OF SPACE AND CAR RETURN                *delimitMateExpansion*
"
" When the cursor is inside an empty pair of any matchpair, <Space> and <CR> can be
" expanded, see |'delimitMate_expand_space'| and
" |'delimitMate_expand_cr'|:
"
" Expand <Space> to: >
"
"                     You start with  |  You get
"                   ==============================
"                         (|)         |    ( | )
" <
" Expand <CR> to: >
"
"                    You start with   |  You get
"                   ==============================
"                         (|)         |    (
"                                     |      |
"                                     |    )
" <
"
" When you have |'delimitMate_jump_expansion'| enabled, if there is an existing
" closing paren/bracket/etc. on the next line, delimitMate will make the cursor
" jump over any whitespace/<CR> and place it after the existing closing
" delimiter instead of inserting a new one.
"
" When |'delimitMate_expand_cr'| is set to 2, the following will also happen: >
"
"                     You start with  |  You get
"                   ==============================
"                        (foo|)       |    (foo
"                                     |      |
"                                     |    )
" <
"
" Since <Space> and <CR> are used everywhere, I have made the functions involved
" in expansions global, so they can be used to make custom mappings. Read
" |delimitMateFunctions| for more details.
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1
let g:delimitMate_jump_expansion = 1
"
" ------------------------------------------------------------------------------
"    3.3 BACKSPACE                                        *delimitMateBackspace*
"
" If you press backspace inside an empty pair, both delimiters are deleted. When
" expansions are enabled, <BS> will also delete the expansions.
"
" If you type <S-BS> (shift + backspace) instead, only the closing delimiter
" will be deleted. NOTE that this will not usually work when using Vim from the
" terminal, see 'delimitMate#JumpAny()' below to see how to fix it.
"
" e.g. typing at the "|": >
"
"                   What  |      Before       |      After
"                ==============================================
"                   <BS>  |  call expand(|)   |  call expand|
"                ---------|-------------------|-----------------
"                   <BS>  |  call expand( | ) |  call expand(|)
"                ---------|-------------------|-----------------
"                   <BS>  |  call expand(     |  call expand(|)
"                         |  |                |
"                         |  )                |
"                ---------|-------------------|-----------------
"                  <S-BS> |  call expand(|)   |  call expand(|
" <
"
" ------------------------------------------------------------------------------
"    3.4 SMART QUOTES                                   *delimitMateSmartQuotes*
"
" Only one quote will be inserted following a quote, a "\", following or
" preceding a keyword character, or when the number of quotes in the current
" line is odd. This should cover closing quotes after a string, opening quotes
" before a string, escaped quotes and apostrophes. See more details about
" customizing this feature on |'delimitMate_smart_quotes'|.
"
" e.g. typing at the "|": >
"
"                      What |    Before    |     After
"                   =======================================
"                       "   |  Text |      |  Text "|"
"                       "   |  "String|    |  "String"|
"                       "   |  let i = "|  |  let i = "|"
"                       'm  |  I|          |  I'm|
" <
let g:delimitMate_smart_quotes = 1
" ------------------------------------------------------------------------------
"    3.4 SMART MATCHPAIRS                           *delimitMateSmartMatchpairs*
"
" This is similar to "smart quotes", but applied to the characters in
" |'delimitMate_matchpairs'|. The difference is that delimitMate will not
" auto-close the pair when the regex matches the text on the right of the
" cursor. See |'delimitMate_smart_matchpairs'| for more details.
"
"
" e.g. typing at the "|": >
"
"                      What |    Before    |     After
"                   =======================================
"                       (   |  function|   |  function(|)
"                       (   |  |var        |  (|var
" <
let g:delimitMate_smart_matchpairs = 1
" ------------------------------------------------------------------------------
"    3.5 BALANCING MATCHING PAIRS                           *delimitMateBalance*
"
" When inserting an opening paren and |'delimitMate_balance_matchpairs'| is
" enabled, delimitMate will try to balance the closing pairs in the current
" line.
"
" e.g. typing at the "|": >
"
"                      What |    Before    |     After
"                   =======================================
"                       (   |      |       |     (|)
"                       (   |      |)      |     (|)
"                       ((  |      |)      |    ((|))
" <
let g:delimitMate_balance_matchpairs = 1
" ------------------------------------------------------------------------------
"    3.6 FILE TYPE BASED CONFIGURATION                     *delimitMateFileType*
"
" delimitMate options can be set globally for all buffers using global
" ("regular") variables in your |vimrc| file. But |:autocmd| can be used to set
" options for specific file types (see |'filetype'|) using buffer variables in
" the following way: >
"
"    au FileType mail,text let b:delimitMate_autoclose = 0
"          ^       ^           ^            ^            ^
"          |       |           |            |            |
"          |       |           |            |            - Option value.
"          |       |           |            - Option name.
"          |       |           - Buffer variable.
"          |       - File types for which the option will be set.
"          - Don't forget to put this event.
" <
" NOTE that you should use buffer variables (|b:var|) only to set options with
" |:autocmd|, for global options use regular variables (|g:var|) in your vimrc.
"
" ------------------------------------------------------------------------------
"    3.7 SYNTAX AWARENESS                                    *delimitMateSyntax*
"
" The features of this plug-in might not be always helpful, comments and strings
" usualy don't need auto-completion. delimitMate monitors which region is being
" edited and if it detects that the cursor is in a comment it'll turn itself off
" until the cursor leaves the comment. The excluded regions can be set using the
" option |'delimitMate_excluded_regions'|. Read |group-name| for a list of
" regions or syntax group names.
"
" NOTE that this feature relies on a proper syntax file for the current file
" type, if the appropiate syntax file doesn't define a region, delimitMate won't
" know about it.
" ------------------------------------------------------------------------------
"    2.1 OPTIONS SUMMARY                              *delimitMateOptionSummary*
"
" The behaviour of this script can be customized setting the following options
" in your vimrc file. You can use local options to set the configuration for
" specific file types, see |delimitMateOptionDetails| for examples.
"
" |'loaded_delimitMate'|            Turns off the script.
"
" |'delimitMate_autoclose'|         Tells delimitMate whether to automagically
"                                 insert the closing delimiter.
"
" |'delimitMate_matchpairs'|        Tells delimitMate which characters are
"                                 matching pairs.
"
" |'delimitMate_quotes'|            Tells delimitMate which quotes should be
"                                 used.
"
" |'delimitMate_nesting_quotes'|    Tells delimitMate which quotes should be
"                                 allowed to be nested.
"
" |'delimitMate_expand_cr'|         Turns on/off the expansion of <CR>.
"
" |'delimitMate_expand_space'|      Turns on/off the expansion of <Space>.
"
" |'delimitMate_jump_expansion'|    Turns on/off jumping over expansions.
"
" |'delimitMate_smart_quotes'|      Turns on/off the "smart quotes" feature.
"
" |'delimitMate_smart_matchpairs'|  Turns on/off the "smart matchpairs" feature.
"
" |'delimitMate_balance_matchpairs'|Turns on/off the "balance matching pairs"
"                                 feature.
"
" |'delimitMate_excluded_regions'|  Turns off the script for the given regions or
"                                 syntax group names.
"
" |'delimitMate_excluded_ft'|       Turns off the script for the given file types.
"
" |'delimitMate_eol_marker'|        Determines what to insert after the closing
"                                 matchpair when typing an opening matchpair on
"                                 the end of the line.
"
" |'delimitMate_apostrophes'|       Tells delimitMate how it should "fix"
"                                 balancing of single quotes when used as
"                                 apostrophes. NOTE: Not needed any more, kept
"                                 for compatibility with older versions.
