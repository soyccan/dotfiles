if not status is-interactive || not test -d (get-default XDG_DATA_HOME $HOME/.local/share/pyenv)
    exit
end

set -x PYENV_ROOT (get-default XDG_DATA_HOME $HOME/.local/share/pyenv)
set -x PYENV_SHELL fish

fish_add_path $PYENV_ROOT/bin
fish_add_path $PYENV_ROOT/shims

# command pyenv rehash 2>/dev/null
