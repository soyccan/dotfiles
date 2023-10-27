# Profiling begin
# zmodload zsh/zprof


## If connected from remote & not in tmux & not from VS Code, enter tmux.
# Attach any existing session (-A). If not available, create a new session
# with the first window running htop.
if [[ ${SSH_CONNECTION+X}
        && -z ${VSCODE_INJECTION+X}${VSCODE_IPC_HOOK_CLI+X}
        && -z ${TMUX+X}${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X} ]]; then
    tmux new-session -dAD "exec htop"
    tmux new-window
    tmux attach
fi


ZSH=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
ZSH_DATA=${XDG_DATA_HOME:-$HOME/.local/share}/zsh
ZSH_PLUGGED=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugged

source $ZSH/lib.zsh


## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
zshrc_plugin_update $ZSH_PLUGGED/powerlevel10k &&
    make -C $ZSH_PLUGGED/powerlevel10k pkg

[[ -r ${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh ]] &&
    source ${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh


## Update or clone plugins and compile them when there is update
zshrc_plugin_update $ZSH_PLUGGED/fast-syntax-highlighting &&
    zshrc_zcompile_many $ZSH_PLUGGED/fast-syntax-highlighting/**/*.zsh

zshrc_plugin_update $ZSH_PLUGGED/zsh-autosuggestions &&
    zshrc_zcompile_many $ZSH_PLUGGED/zsh-autosuggestions/**/*.zsh

zshrc_plugin_update $ZSH_PLUGGED/zsh-completions &&
    zshrc_zcompile_many $ZSH_PLUGGED/zsh-completions/**/*.zsh

zshrc_plugin_update $ZSH_PLUGGED/ohmyzsh &&
    zshrc_zcompile_many $ZSH_PLUGGED/ohmyzsh/lib/*.zsh

if zshrc_plugin_update $ZSH_PLUGGED/fzf ||
        [[ ! -e $ZSH_PLUGGED/fzf/bin/fzf || ! -e $HOME/.local/bin/fzf ]]; then
    # TODO: always use the downloaded binary
    $ZSH_PLUGGED/fzf/install --bin
    zshrc_mkshim fzf $ZSH_PLUGGED/fzf/bin/fzf
fi

zshrc_plugin_update $ZSH_PLUGGED/fasd
# TODO: always use the downloaded binary
# zshrc_mkshim fasd $ZSH_PLUGGED/fasd/fasd


## Pre-Plugin tasks
# configs that need to be loaded before plugins are loaded

# Enable the "new" completion system (compsys)
autoload -Uz compinit && compinit
[[ ~/.zcompdump.zwc -nt ~/.zcompdump ]] || zshrc_zcompile_many ~/.zcompdump

# setup environment
source $ZSH/env.zsh

# key bindings need to be loaded before zsh-syntax-highlighting
source $ZSH/key-bindings.zsh


## Load plugins
# remember to clone them first

# Fast Syntax Highlighting: Feature rich syntax highlighting for Zsh
source $ZSH_PLUGGED/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# zsh-autosuggestions: Fish-like fast/unobtrusive autosuggestions for zsh
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
source $ZSH_PLUGGED/zsh-autosuggestions/zsh-autosuggestions.zsh

# Powerlevel10k: A theme for Zsh
source $ZSH_PLUGGED/powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.p10k.zsh

# zsh-completions: Additional completion definitions for Zsh
source $ZSH_PLUGGED/zsh-completions/zsh-completions.plugin.zsh

# Oh My Zsh
source $ZSH_PLUGGED/ohmyzsh/lib/completion.zsh
source $ZSH_PLUGGED/ohmyzsh/lib/functions.zsh
source $ZSH_PLUGGED/ohmyzsh/lib/history.zsh
source $ZSH_PLUGGED/ohmyzsh/lib/theme-and-appearance.zsh
function {
    # Load colors
    # Plugin `colored-man-pages` requires this
    autoload -Uz colors
    colors

    local name
    for name in colored-man-pages \
                command-not-found \
                encode64 \
                systemadmin \
                systemd \
                extract \
                git; do
        source $ZSH_PLUGGED/ohmyzsh/plugins/$name/$name.plugin.zsh
    done
}

# require ohmyzsh plugin `extract`
zshrc_fetch_bin bat https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-x86_64-unknown-linux-musl.tar.gz
zshrc_fetch_bin exa https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-musl-v0.10.1.zip

# globalias: expand glob & alias in command line
source $ZSH/plugins/globalias.plugin.zsh

# fasd & fzf
function {
    # usage: $ <cmd> **<tab>
    source $ZSH_PLUGGED/fzf/shell/completion.zsh

    # ^R : paste selected command histo(r)y into command line
    # ^T : paste selected file/dir under current path (t)ree into command line
    # ALT-C / <ESC>C : (c)d into selected dir under current tree
    source $ZSH_PLUGGED/fzf/shell/key-bindings.zsh

    # override with my widgets & key bindings
    source $ZSH/plugins/fzf.plugin.zsh

    # init fasd
    local fasd_cache=$HOME/.fasd-init-zsh
    if [[ $(command -v fasd) -nt $fasd_cache || ! -s $fasd_cache ]]; then
        fasd --init zsh-hook zsh-ccomp zsh-ccomp-install \
            zsh-wcomp zsh-wcomp-install >| $fasd_cache
    fi
    source $fasd_cache
}


## Post-plugin tasks

# Load my configs (overrides loaded plugins)
source $ZSH/alias.zsh

# my completions
fpath+=$ZSH_DATA/completions

# Pull new changes of dotfiles in background
zshrc_has yadm && (yadm pull &>/dev/null &)


# Profiling end
# zprof
