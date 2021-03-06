" Copied from ale/autoload/ale/handlers/cppcheck.vim
" Fix cppcheck output format
"
" Description: Handle errors for cppcheck.

function! ale#handlers#cppcheck#GetCdCommand(buffer) abort
    let [l:dir, l:json_path] = ale#c#FindCompileCommands(a:buffer)
    let l:cd_command = !empty(l:dir) ? ale#path#CdString(l:dir) : ''

    return l:cd_command
endfunction

function! ale#handlers#cppcheck#GetBufferPathIncludeOptions(buffer) abort
    let l:buffer_path_include = ''

    " Get path to this buffer so we can include it into cppcheck with -I
    " This could be expanded to get more -I directives from the compile
    " command in compile_commands.json, if it's found.
    let l:buffer_path = fnamemodify(bufname(a:buffer), ':p:h')
    let l:buffer_path_include = ' -I' . ale#Escape(l:buffer_path)

    return l:buffer_path_include
endfunction

function! ale#handlers#cppcheck#GetCompileCommandsOptions(buffer) abort
    " If the current buffer is modified, using compile_commands.json does no
    " good, so include the file's directory instead. It's not quite as good as
    " using --project, but is at least equivalent to running cppcheck on this
    " file manually from the file's directory.
    let l:modified = getbufvar(a:buffer, '&modified')

    if l:modified
        return ''
    endif

    " Search upwards from the file for compile_commands.json.
    "
    " If we find it, we'll `cd` to where the compile_commands.json file is,
    " then use the file to set up import paths, etc.
    let [l:dir, l:json_path] = ale#c#FindCompileCommands(a:buffer)

    return !empty(l:json_path)
    \   ? '--project=' . ale#Escape(l:json_path[len(l:dir) + 1: ])
    \   : ''
endfunction

function! ale#handlers#cppcheck#HandleCppCheckFormat(buffer, lines) abort
    " Look for lines like the following.
    "
    " Deprecated:
    " [test.cpp:5]: (error) Array 'a[10]' accessed at index 10, which is out of bounds
    " let l:pattern = '\v^\[(.+):(\d+)\]: \(([a-z]+)\) (.+)$'
    "
    " Newer:
    " parser.hpp:10:18: error: No pair for character ("). Can't process file. File is either invalid or unicode, which is currently not supported. [syntaxError]
    let l:pattern = '\v^(.+):(\d+):(\d+): ([a-z]+): (.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            call add(l:output, {
            \   'lnum': str2nr(l:match[2]),
            \   'type': l:match[4] is# 'error' ? 'E' : 'W',
            \   'text': l:match[5],
            \})
        endif
    endfor

    return l:output
endfunction
