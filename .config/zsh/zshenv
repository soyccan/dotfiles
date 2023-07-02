function has { [[ $commands[$1] ]] }

# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# PATH
function {
    # null_glob: ignore error when globbing fails (/path/to/some/dir/* not exist)
    [[ -o null_glob ]] && local null_glob_set=1 || local null_glob_set=
    setopt null_glob

    local new_path=()
    local p

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

    # Python pyenv & pips
    # Linux
    new_path+=$HOME/.pyenv/bin
    new_path+=$HOME/.local/bin
    # masOS
    new_path+=(/Library/Frameworks/Python.framework/Versions/Current/bin)
    for p in $HOME/Library/Python/*/bin; do
        new_path+=$p
    done

    # Foundry
    new_path+="/home/soyccan/.foundry/bin"

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
if has nvim; then
    export EDITOR='nvim'
elif has vim; then
    export EDITOR='vim'
elif has vi; then
    export EDITOR='vi'
elif has nano; then
    export EDITOR='nano'
fi

# Homebrew
has brew && export HOMEBREW_NO_AUTO_UPDATE=1

# Node.js Version Manager (NVM)
if [[ -d "$HOME/.config/nvm" ]]; then
    export NVM_DIR="$HOME/.config/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Rust
if [[ -e "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

# Pyenv
if [[ -d "$HOME/.pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# AWS CLI
if has aws && has aws_completer; then
    autoload bashcompinit && bashcompinit
    autoload -Uz compinit && compinit
    complete -C $(which aws_completer) aws # TODO: this does not work
fi

unfunction has

