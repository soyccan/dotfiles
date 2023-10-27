# Library functions for .zshrc and relevant config scripts
# All functions are prefixed with zshrc- to avoid pollution

function zshrc_zcompile_many {
    local f
    for f; do zcompile -R -- "$f".zwc "$f"; done
}

function zshrc_plugin_ready() {
    local submodule=$1
    [[ -e $submodule/.git ]]
}

# Plugins are included as submodules of my dotfiles repo.
# This function updates the plugin to the latest commit, or clone it if not exist.
# Returns success if an update or new clone is completed, and return fail when nothing should be done
function zshrc_plugin_update {
    if ! zshrc_has yadm; then
        echo "yadm not installed"
        return 1
    fi

    local submodule=$1

    if zshrc_plugin_ready $submodule; then
        # ready: nothing to do
        return 1
    fi

    output=$(yadm submodule update --init --depth=1 --remote $submodule)
    if [[ $? = 0 && $output ]]; then
        # success
        return 0
    else
        # nothing to do
        return 1
    fi
}

# make a shim: a wrapper script that forwards the call to the actual binary,
# which may be located in a user dir
function zshrc_mkshim {
    local name=$1
    local binpath=$2

    mkdir -p $HOME/.local/bin
    echo -e "#!/bin/sh\n$binpath \"\$@\"" > $HOME/.local/bin/$name
    chmod +x $HOME/.local/bin/$name
}

function zshrc_fetch_bin {
    local binname=$1
    local url=$2

    [[ -e $HOME/.local/bin/$binname ]] && return 1

    (
        cd $(mktemp -d) || exit
        curl -fLO $url
        extract ${url##*/}
        cp -f **/$binname $HOME/.local/bin/$binname
    )
}

# Check if command exists, return 0 on success
# much faster than external program `which` as no forking is needed
# instead, it searches in the external commands hash table
# unlike `command -v`, `type` or `whence -v`, it excludes aliases
# https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#index-commands
function zshrc_has { [[ $commands[$1] ]] }

# Determine OS
function zshrc_is_macos { [[ $OSTYPE = darwin* ]] }
function zshrc_is_linux { [[ $OSTYPE = linux* ]] }

