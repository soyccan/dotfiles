if not status is-interactive || not test -d "$HOME/.pyenv"
    exit
end

set -x PYENV_ROOT "$HOME/.pyenv"
set -x PYENV_SHELL fish

fish_add_path --global $PYENV_ROOT/bin
fish_add_path --global $PYENV_ROOT/shims

# fish_add_path --global $PYENV_ROOT/versions/(pyenv version-name)/bin
# command pyenv rehash 2>/dev/null
