# Node.js Version Manager (NVM)
if [[ -d "$HOME/.config/nvm" ]]; then
    export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
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

# Haskell
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# AWS CLI
# if zshrc_has aws && zshrc_has aws_completer; then
#     autoload bashcompinit && bashcompinit
#     autoload -Uz compinit && compinit
#     complete -C $(which aws_completer) aws # TODO: this does not work
# fi

# Nix
if [[ ! $NIX_PROFILES && -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
    source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
