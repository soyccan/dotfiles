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


## Global variables & functions for zshrc
ZSH=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
ZSH_PLUGGED=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugged

gbl_funcs=()

function zcompile-many {
    local f
    for f; do zcompile -R -- "$f".zwc "$f"; done
}
gbl_funcs+=zcompile-many

# Enable the "new" completion system (compsys)
autoload -Uz compinit && compinit
[[ ~/.zcompdump.zwc -nt ~/.zcompdump ]] || zcompile-many ~/.zcompdump

# Clone plugins included as submodules of my dotfiles repo
# return 1 if already cloned, 0 otherwise
function clone-plugin {
    local name=$1
    if [[ "$(<$HOME/.local/share/yadm/repo.git/config)" != *$name* ]]; then
        # if .git/config contains no $name string
        # we say the submodule is not cloned, and clone it
        git -C $ZSH_PLUGGED submodule update --init --depth=1 $name
        return 0
    fi
    return 1
}
gbl_funcs+=clone-plugin

# make a shim: a wrapper script that forwards the call to the actual binary,
# which may be located in a user dir
function mkshim {
    local name=$1
    local binpath=$2

    mkdir -p $HOME/.local/bin
    echo -e "#!/bin/sh\n$binpath \"\$@\"" > $HOME/.local/bin/$name
    chmod +x $HOME/.local/bin/$name
}
gbl_funcs+=mkshim

function download_bin {
    local binname=$1
    local url=$2
    (
        cd $(mktemp -d) || exit
        curl -fLO $url
        extract ${url##*/}
        cp -f **/$binname $HOME/.local/bin/$binname
    )
}
gbl_funcs+=download_bin

# Check if command exists, return 0 on success
# much faster than external program `which` as no forking is needed
# instead, it searches in the external commands hash table
# unlike `command -v`, `type` or `whence -v`, it excludes aliases
# https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#index-commands
function has { [[ $commands[$1] ]] }
gbl_funcs+=has

# Determine OS
function is_macos { [[ $OSTYPE = darwin* ]] }
function is_linux { [[ $OSTYPE = linux* ]] }
gbl_funcs+=(is_macos is_linux)


## Clone and compile to wordcode missing plugins
clone-plugin fast-syntax-highlighting &&
    zcompile-many $ZSH_PLUGGED/fast-syntax-highlighting/**/*.zsh

clone-plugin zsh-autosuggestions &&
    zcompile-many $ZSH_PLUGGED/zsh-autosuggestions/**/*.zsh

clone-plugin powerlevel10k &&
    make -C $ZSH_PLUGGED/powerlevel10k pkg

clone-plugin zsh-completions &&
    zcompile-many $ZSH_PLUGGED/zsh-completions/**/*.zsh

clone-plugin ohmyzsh &&
    zcompile-many $ZSH_PLUGGED/ohmyzsh/lib/*.zsh

# TODO: include fzf, fasd, exa, bat... binaries in PATH
# may refer to zinit annex bin-gem-node
clone-plugin fzf
if ! has fzf; then
    $ZSH_PLUGGED/fzf/install --bin
    mkshim fzf $ZSH_PLUGGED/fzf/bin/fzf
fi

clone-plugin fasd
has fasd || mkshim fasd $ZSH_PLUGGED/fasd/fasd


## Activate Powerlevel10k Instant Prompt
[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] &&
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"


## Pre-Plugin settings
# configs that need to be loaded before plugins are loaded

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
fpath+=$ZSH_PLUGGED/zsh-completions/src

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
has bat || download_bin bat https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-x86_64-unknown-linux-musl.tar.gz
has exa || download_bin exa https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-musl-v0.10.1.zip

# globalias: expand glob & alias in command line
source $ZSH/plugins/globalias.plugin.zsh

# fasd & fzf
[[ $- == *i* ]] && function {
    # if shell is interactive

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


## Epilogue

# Load my configs (overrides loaded plugins)
source $ZSH/aliases.zsh

# my functions & completions
fpath+=$ZSH/functions
fpath+=$ZSH/functions/vendor-completions

# Pull new changes of dotfiles in background
has yadm && (yadm pull &>/dev/null &)

unfunction $gbl_funcs
unset gbl_funcs


# Profiling end
# zprof
