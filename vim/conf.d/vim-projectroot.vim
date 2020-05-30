" =============================================================================
" CUSTOMIZING           *projectroot-customizing*
"
"                 *'g:rootmarkers'*
" Default: ['.projectroot','.git','.hg','.svn','.bzr','_darcs','build.xml']
" From the given file, the presence of these markers is checked in-order in
" order to detect the projectroot. This means that `.projectroot` has the
" highest priority, `.git` second highest and so on. >
"     let g:rootmarkers = ['.svn', '.git']
" <
let g:rootmarkers = ['.gitignore', '.clang-format',
            \        'README', 'README.md', 'README.txt',
            \        '.projectroot', '.git', '.hg', '.svn', '.bzr', '_darcs', 'build.xml']
"
"                 *'b:projectroot'*
" Default: None
" This variable can be used to set a custom project root for the current buffer.
" If this folder exists and is a valid parent of the given file, it will be
" used as the project root. >
"     let b:projectroot = '~/foo/bar'
" <
"
"                 *'g:projectroot_noskipbufs'*
" Default: 0
" The default behavior of ProjectBufNext and ProjectBufPrev is to skip buffers
" that are already visible in the current tabpage. This is generally the right
" thing to do because, well, who needs 2 windows of the same thing?
" If you prefer not to have this behavior use: >
"
"     let g:projectroot_noskipbufs = 1
"
" =============================================================================
