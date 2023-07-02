# A shim to `brew install` with recording installed packages
# Let's brew it!
if has brew; then
    brewit() {
        brewit_txt="$HOME/dotfiles/zsh/brewit.txt"

        # parse arguments
        to_install=()
        switches=''
        for arg in "$@"; do
            if [ "${arg:0:1}" = '-' ]; then
                switches="$switches $arg"
            else
                to_install+=("$arg")
            fi
        done

        # read installed packages from file
        # $(</path/to/file) reads content of the file
        # and in ${(@f)"some string with newline"}
        # (f) splits the result of the expansion at newlines
        # (@) indicates that the words split should be seen as an array
        # refer to:
        # http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
        # at last, name=(value ...) is to assign an array
        installed=(${(@f)"$(<$brewit_txt)"})

        for pkg in $to_install; do
            # $arr[(r)value] is reversed indexing, which returns value if $arr
            # contains it
            # refer to:
            # http://zsh.sourceforge.net/Doc/Release/Parameters.html#Subscript-Flags
            elem="$installed[(r)$pkg]"

            if [ ! "$elem" ]; then
                # if $pkg is not in installed list
                installed+=("$pkg")
            fi
        done

        # write back to file
        # (F) joins the array with newlines
        echo ${(F)installed} > "$brewit_txt"

        # pass through
        brew install "$@"
    }
fi
