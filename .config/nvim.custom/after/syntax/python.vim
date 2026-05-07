syntax keyword Boolean True False None

" f-string
" Reference: https://phelipetls.github.io/posts/f-strings-syntax-highlighting-in-vim/
syntax match pythonEscape +{{+ contained containedin=pythonfString,pythonfDocstring
syntax match pythonEscape +}}+ contained containedin=pythonfString,pythonfDocstring

syntax region pythonfString matchgroup=pythonQuotes
      \ start=+[fF]\@1<=\z(['"]\)+ end="\z1"
      \ contains=@Spell,pythonEscape,pythonInterpolation

syntax region pythonfDocstring matchgroup=pythonQuotes
      \ start=+[fF]\@1<=\z('''\|"""\)+ end="\z1" keepend
      \ contains=@Spell,pythonEscape,pythonSpaceError,pythonInterpolation,pythonDoctest

syntax region pythonInterpolation contained
      \ matchgroup=SpecialChar
      \ start=+{{\@!+ end=+}}\@!+ skip=+{{+ keepend
      \ contains=ALLBUT,pythonDecoratorName,pythonDecorator,pythonFunction,pythonDoctestValue,pythonDoctest

syntax match pythonStringModifier /:\(.[<^=>]\)\?[-+ ]\?#\?0\?[0-9]*[_,]\?\(\.[0-9]*\)\?[bcdeEfFgGnosxX%]\?/ contained containedin=pythonInterpolation
syntax match pythonStringModifier /![sra]/ contained containedin=pythonInterpolation

highlight link pythonfString String
highlight link pythonfDocstring String
highlight link pythonStringModifier PreProc
