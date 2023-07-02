" ==============================================================================
"  2. CUSTOMIZATION                                         *delimitMateOptions*
"
" You can create your own mappings for some features using the global functions.
" Read |delimitMateFunctions| for more info.

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
"
" ------------------------------------------------------------------------------
"    2.2 OPTIONS DETAILS                              *delimitMateOptionDetails*
"
" Add the shown lines to your vimrc file in order to set the below options.
" Buffer variables take precedence over global ones and can be used along with
" autocmd to modify delimitMate's behavior for specific file types, read more in
" |delimitMateFileType|.
"
" Note: Use buffer variables only to set options for specific file types using
" :autocmd, use global variables to set options for all buffers. Read more in
" |g:var| and |b:var|.
"
" ------------------------------------------------------------------------------
"                                                         *'loaded_delimitMate'*
"                                                       *'b:loaded_delimitMate'*
" This option prevents delimitMate from loading.
" e.g.: >
"         let loaded_delimitMate = 1
"         au FileType mail let b:loaded_delimitMate = 1
" <
" ------------------------------------------------------------------------------
"                                                   *'delimitMate_offByDefault'*
" Values: 0 or 1.~
" Default: 0~
"
" If this option is set to 1, delimitMate will load, but will not take
" effect in any buffer unless |:DelimitMateSwitch| is called in that
" buffer.
"
" ------------------------------------------------------------------------------
"                                                      *'delimitMate_autoclose'*
"                                                    *'b:delimitMate_autoclose'*
" Values: 0 or 1.                                                              ~
" Default: 1                                                                   ~
"
" If this option is set to 0, delimitMate will not add a closing delimiter
" automagically. See |delimitMateAutoClose| for details.
" e.g.: >
"         let delimitMate_autoclose = 0
"         au FileType mail let b:delimitMate_autoclose = 0
" <
" ------------------------------------------------------------------------------
"                                                     *'delimitMate_matchpairs'*
"                                                   *'b:delimitMate_matchpairs'*
" Values: A string with |'matchpairs'| syntax, plus support for multi-byte~
"         characters.~
" Default: &matchpairs                                                         ~
"
" Use this option to tell delimitMate which characters should be considered
" matching pairs. Read |delimitMateAutoClose| for details.
" e.g: >
"         let delimitMate_matchpairs = "(:),[:],{:},<:>"
"         au FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
" <
" ------------------------------------------------------------------------------
"                                                         *'delimitMate_quotes'*
"                                                       *'b:delimitMate_quotes'*
" Values: A string of characters separated by spaces.                          ~
" Default: "\" ' `"                                                            ~
"
" Use this option to tell delimitMate which characters should be considered as
" quotes. Read |delimitMateAutoClose| for details.
" e.g.: >
"         let delimitMate_quotes = "\" ' ` *"
"         au FileType html let b:delimitMate_quotes = "\" '"
" <
" ------------------------------------------------------------------------------
"                                                 *'delimitMate_nesting_quotes'*
"                                               *'b:delimitMate_nesting_quotes'*
" Values: A list of quotes.                                                    ~
" Default: []                                                                  ~
"
" When adding a third quote listed in this option is inserted, three quotes will
" be inserted to the right of the cursor and the cursor will stay in the middle.
" If more quotes are inserted the number of quotes on both sides of the cursor
" will stay balanced.
" e.g.: >
"         let delimitMate_nesting_quotes = ['"','`']
"         au FileType python let b:delimitMate_nesting_quotes = ['"']
" <
" For Python this is set by default by the plugin.
"
" ------------------------------------------------------------------------------
"                                                      *'delimitMate_expand_cr'*
"                                                    *'b:delimitMate_expand_cr'*
" Values: 0, 1 or 2                                                             ~
" Default: 0                                                                   ~
"
" This option turns on/off the expansion of <CR>. Read |delimitMateExpansion|
" for details. NOTE This feature requires that 'backspace' is either set to 2 or
" has "eol" and "start" as part of its value.
" e.g.: >
"         let delimitMate_expand_cr = 1
"         au FileType mail let b:delimitMate_expand_cr = 1
" <
let g:delimitMate_expand_cr = 2
" ------------------------------------------------------------------------------
"                                                   *'delimitMate_expand_space'*
"                                                 *'b:delimitMate_expand_space'*
" Values: 1 or 0                                                               ~
" Default: 0                                                                   ~
" This option turns on/off the expansion of <Space>. Read |delimitMateExpansion|
" for details.
" e.g.: >
"         let delimitMate_expand_space = 1
"         au FileType tcl let b:delimitMate_expand_space = 1
" <
let g:delimitMate_expand_space = 1
" ------------------------------------------------------------------------------
"                                           *'delimitMate_expand_inside_quotes'*
"                                         *'b:delimitMate_expand_inside_quotes'*
" Values: 1 or 0                                                                ~
" Default: 0                                                                   ~
" When this option is set to 1 the expansion of space and cr will also be
" applied to quotes. Read |delimitMateExpansion| for details.
"
" e.g.: >
"         let delimitMate_expand_inside_quotes = 1
"         au FileType mail let b:delimitMate_expand_inside_quotes = 1
" <
" ------------------------------------------------------------------------------
"                                                 *'delimitMate_jump_expansion'*
"                                               *'b:delimitMate_jump_expansion'*
" Values: 1 or 0                                                               ~
" Default: 0                                                                   ~
" This option turns on/off the jumping over <CR> and <Space> expansions when
" inserting closing matchpairs. Read |delimitMateExpansion| for details.
" e.g.: >
"         let delimitMate_jump_expansion = 1
"         au FileType tcl let b:delimitMate_jump_expansion = 1
" <
let g:delimitMate_jump_expansion = 0
" ------------------------------------------------------------------------------
"                                                   *'delimitMate_smart_quotes'*
"                                                 *'b:delimitMate_smart_quotes'*
" Values: String with an optional !  at the beginning followed by a regexp     ~
" Default:~
" '\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'                  ~
"
" A bang (!) at the beginning is removed and used to "negate" the pattern. The
" remaining text is used as a regexp to be matched on the current line. A single
" quote is inserted when the pattern matches and a bang is not present. The bang
" changes that, so a single quote is inserted only if the regexp does not match.
"
" This feature is disabled when the variable is set to an empty string, with the
" exception of apostrophes.
"
" Note that you need to use '\%#' to match the position of the cursor.  Keep in
" mind that '\%#' matches with zero width, so if you need to match the char
" under the cursor (which would be the one to the right on insert mode) use
" something like '\%#.'.
"
" e.g.: >
"         let delimitMate_smart_quotes = '\w\%#'
"         au FileType tcl let b:delimitMate_smart_quotes = '!\s\%#\w'
" <
" ------------------------------------------------------------------------------
"                                               *'delimitMate_smart_matchpairs'*
"                                             *'b:delimitMate_smart_matchpairs'*
" Values: Regexp                                                               ~
" Default: '^\%(\w\|\!\|[£$]\|[^[:space:][:punct:]]\)'                                ~
"
" This regex is matched against the text to the right of cursor, if it's not
" empty and there is a match delimitMate will not autoclose the pair. At the
" moment to match the text, an escaped bang (\!) in the regex will be replaced
" by the character being inserted, while an escaped number symbol (\#) will be
" replaced by the closing pair.
" e.g.: >
"         let delimitMate_smart_matchpairs = ''
"         au FileType tcl let b:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'
" <
" ------------------------------------------------------------------------------
"                                             *'delimitMate_balance_matchpairs'*
"                                           *'b:delimitMate_balance_matchpairs'*
" Values: 1 or 0                                                               ~
" Default: 0                                                                   ~
"
" This option turns on/off the balancing of matching pairs. Read
" |delimitMateBalance| for details.
" e.g.: >
"         let delimitMate_balance_matchpairs = 1
"         au FileType tcl let b:delimitMate_balance_matchpairs = 1
" <
let g:delimitMate_balance_matchpairs = 1
" ------------------------------------------------------------------------------
"                                               *'delimitMate_excluded_regions'*
" Values: A string of syntax group names names separated by single commas.     ~
" Default: Comment                                                             ~
"
" This options turns delimitMate off for the listed regions, read |group-name|
" for more info about what is a region.
" e.g.: >
"         let delimitMate_excluded_regions = "Comment,String"
" <
" ------------------------------------------------------------------------------
"                                                    *'delimitMate_excluded_ft'*
" Values: A string of file type names separated by single commas.              ~
" Default: Empty.                                                              ~
"
" This options turns delimitMate off for the listed file types, use this option
" only if you don't want any of the features it provides on those file types.
" e.g.: >
"         let delimitMate_excluded_ft = "mail,txt"
" <
" ------------------------------------------------------------------------------
"                                              *'delimitMate_insert_eol_marker'*
" Values: Integer                                                              ~
" Default: 1                                                              ~
"
" Whether to insert the eol marker (EM) or not. The EM is inserted following
" rules:
"
" 0 -> never
" 1 -> when inserting any matchpair
" 2 -> when expanding car return in matchpair
"
" e.g.: >
"         au FileType c,perl let b:delimitMate_insert_eol_marker = 2
" <
" ------------------------------------------------------------------------------
"                                                     *'delimitMate_eol_marker'*
" Values: String.                                                              ~
" Default: Empty.                                                              ~
"
" The contents of this string will be inserted after the closing matchpair or
" quote when the respective opening matchpair or quote is inserted at the end
" of the line.
" e.g.: >
"         au FileType c,perl let b:delimitMate_eol_marker = ";"
" <
" ------------------------------------------------------------------------------
"                                                    *'delimitMate_apostrophes'*
" Values: Strings separated by ":".                                            ~
" Default: No longer used.                                                     ~
"
" NOTE: This feature is turned off by default, it's been kept for compatibility
" with older version, read |delimitMateSmartQuotes| for details.
" If auto-close is enabled, this option tells delimitMate how to try to fix the
" balancing of single quotes when used as apostrophes. The values of this option
" are strings of text where a single quote would be used as an apostrophe (e.g.:
" the "n't" of wouldn't or can't) separated by ":". Set it to an empty string to
" disable this feature.
" e.g.: >
"         let delimitMate_apostrophes = ""
"         au FileType tcl let delimitMate_apostrophes = ""
" <
" ==============================================================================
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
" ------------------------------------------------------------------------------
