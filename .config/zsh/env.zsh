# PATH
function {
    # null_glob: ignore error when globbing fails (/path/to/some/dir/* not exist)
    [[ -o null_glob ]] && local null_glob_set=1 || local null_glob_set=
    setopt null_glob

    local new_path=()
    local p

    # Recommended place for user-specific executable files by XDG Base Directory Specification
    # executables installed by pip are also here
    new_path+=$HOME/.local/bin

    # Snap
    new_path+=/snap/bin

    # Go
    new_path+=$HOME/go/bin

    # Haskell
    new_path+=($HOME/.ghcup/bin $HOME/.cabal/bin)

    # Ruby rvm & gems
    new_path+=$HOME/.rvm/bin
    for p in $HOME/.gem/ruby/*; do
        new_path+=$p/bin
    done

    # Python (pyenv)
    new_path+=$HOME/.pyenv/bin

    # Python (masOS)
    new_path+=(/Library/Frameworks/Python.framework/Versions/Current/bin)
    for p in $HOME/Library/Python/*/bin; do
        new_path+=$p
    done

    # Foundry
    new_path+=$HOME/.foundry/bin

    # update PATH env var
    for p in $new_path; do
        # if $p exists as a dir & not in current $PATH, prepend it to $PATH
        [[ -d $p && ! ${path[(r)$p]} ]] && path=($p $path)
    done

    [[ ! $null_glob_set ]] && unsetopt null_glob
}

# Man pages path
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if zshrc_has nvim; then
    export EDITOR='nvim'
elif zshrc_has vim; then
    export EDITOR='vim'
elif zshrc_has vi; then
    export EDITOR='vi'
elif zshrc_has nano; then
    export EDITOR='nano'
fi

# Homebrew
zshrc_has brew && export HOMEBREW_NO_AUTO_UPDATE=1

# pagers
export LESSOPEN="|/bin/lesspipe %s"
export BAT_PAGER="/usr/bin/less -RFi" # ignore case

