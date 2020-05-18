#!/bin/bash

if [ "$1" = 'clean' ]; then
    echo 'Are you sure? (yes)'
    read -r ans
    if [ "$ans" = 'yes' ]; then
        echo Cleaning
        rm -rf "$HOME/.oh-my-zsh" \
            "$HOME/.zshrc" \
            "$HOME/.tmux" \
            "$HOME/.tmux.conf" \
            "$HOME/.tmux.conf.local" \
            "$HOME/.vim" \
            "$HOME/.config/nvim" \
            "$HOME/.gdb" \
            "$HOME/.gdbinit"
    fi
    exit
fi


dotfiles="$(pwd)/$(dirname "$0")"


ln_confirm() {
    src="$1"
    link="$2"
    if [ -L "$link" ]; then
        ln -svf "$src" "$link"
    else
        ln -svi "$src" "$link"
    fi
}


get_package_manager() (
    # following will be executed in a subshell
    . /etc/os-release
    if [ "$NAME" = "CentOS Linux" ]; then
        echo yum
    elif [ "$NAME" = "Ubuntu" ]; then
        echo apt
    fi
)


setup_zsh() {
    echo Configuring ZSH

    if ! command -v zsh >/dev/null; then
        echo Installing ZSH
        sudo "$(get_package_manager)" install zsh
    fi
    sudo usermod "$USER" -s /bin/zsh

    # oh-my-zsh
    echo Installing Oh My ZSH
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ln_confirm "$dotfiles/zsh/zshrc" "$HOME/.zshrc"

    # download third-party plugins
    git clone --depth 1 https://github.com/Powerlevel9k/powerlevel9k "$HOME/.oh-my-zsh/custom/themes/powerlevel9k"
    git clone --depth 1 https://github.com/romkatv/powerlevel10k "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    git clone --depth 1 https://github.com/zsh-users/zsh-completions "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
    git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search "$HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search"
    git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

    # powerlever10k
    ln_confirm "$dotfiles/zsh/p10k.zsh" "$HOME/.p10k.zsh"

    # install my plugin
    mkdir -pv "$HOME/.oh-my-zsh/custom/plugins/urlencode"
    ln_confirm "$dotfiles/zsh/urlencode.sh" "$HOME/.oh-my-zsh/custom/plugins/urlencode/urlencode.plugin.zsh"
}


setup_fish() {
    echo Configuring FISH

    if ! command -v fish >/dev/null; then
        echo Installing FISH
        sudo "$(get_package_manager)" install fish
    fi

    sudo usermod "$USER" -s /bin/fish

    # oh-my-fish
    curl -L https://get.oh-my.fish | fish
}


setup_tmux() {
    echo Configuring TMUX

    if ! command -v zsh >/dev/null; then
        echo Installing TMUX
        sudo "$(get_package_manager)" install tmux
    fi

    # oh-my-tmux
    echo Installing Oh My TMUX
    git clone --depth 1 https://github.com/gpakosz/.tmux "$HOME/.tmux"
    ln_confirm "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
    ln_confirm "$dotfiles/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"
}


setup_vim() {
    echo Configuring Vim

    if ! command -v nvim >/dev/null; then
        echo Installing NeoVim
        sudo "$(get_package_manager)" install neovim
    fi

    # neovim configurations
    ln_confirm "$dotfiles/vim" "$HOME/.config/nvim"

    # vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # compatible with vim
    ln_confirm "$dotfiles/vim" "$HOME/.vim"
    ln_confirm "$dotfiles/vim/init.vim" "$HOME/.vimrc"
}


setup_gdb() {
    echo Configuring GDB

    if ! command -v gdb >/dev/null; then
        echo Installing GDB
        sudo "$(get_package_manager)" install gdb
    fi

    mkdir "$HOME/.gdb"
    git clone --depth 1 https://github.com/longld/peda "$HOME/.gdb/peda"
    git clone --depth 1 https://github.com/pwndbg/pwndbg "$HOME/.gdb/pwndbg"
    git clone --depth 1 https://github.com/scwuaptx/Pwngdb "$HOME/.gdb/Pwngdb"
    git clone --depth 1 https://github.com/cloudburst/libheap "$HOME/.gdb/libheap"
    ln_confirm "$dotfiles/gdb/gdbinit" "$HOME/.gdbinit"

    # lldb
    ln_confirm "$dotfiles/gdb/lldbinit" "$HOME/.lldbinit"
}


main() {
    setup_tmux
    setup_fish
    setup_zsh
    setup_vim
    echo Voila! Setup Finished!
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    # if this script is being executed, not sourced
    main
fi
