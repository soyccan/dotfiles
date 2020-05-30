#!/bin/bash


dotfiles="$(realpath "$(dirname "$0")")"


has() {
    command -v "$1" >/dev/null 2>&1
}

ln_confirm() {
    src="$1"
    link="$2"
    mkdir -p "$(dirname "$link")"
    if [ -L "$link" ]; then
        ln -svf "$src" "$link"
    else
        ln -svi "$src" "$link"
    fi
}

get_package_manager() {
    for cmd in apt yum brew; do 
        if has cmd; then
            echo "$cmd"
            break
        fi
    done
}


setup_zsh() {
    echo Configuring ZSH

    if ! has zsh; then
        echo Installing ZSH
        sudo "$(get_package_manager)" install zsh
    fi

    if [ "$(awk -F':' "/^$USER/ { print \$7 }" /etc/passwd)" != '/bin/zsh' ]; then
        sudo usermod "$USER" -s /bin/zsh
    fi

    # config files
    ln_confirm "$dotfiles/zsh/zshrc" "$HOME/.zshrc"
    ln_confirm "$dotfiles/zsh" "$HOME/.config/zsh"

    # zinit - faster plugin manager
    if [ ! -d "$HOME/.zinit" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
    fi

    # powerlever10k
    # ln_confirm "$dotfiles/zsh/p10k.zsh" "$HOME/.p10k.zsh"
    p10k configure

    # install my plugin
    # mkdir -pv "$HOME/.oh-my-zsh/custom/plugins/urlencode"
    # ln_confirm "$dotfiles/zsh/urlencode.sh" "$HOME/.oh-my-zsh/custom/plugins/urlencode/urlencode.plugin.zsh"
}


setup_fish() {
    echo Configuring FISH

    if ! command -v fish >/dev/null; then
        echo Installing FISH
        sudo "$(get_package_manager)" install fish
    fi

    if [ "$(awk -F':' "/^$USER/ { print \$7 }" /etc/passwd)" != '/bin/fish' ]; then
        sudo usermod "$USER" -s /bin/fish
    fi

    # oh-my-fish
    # curl -L https://get.oh-my.fish | fish

    # fisher
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
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
    # setup_fish
    setup_zsh
    setup_vim
    echo Voila! Setup Finished!
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    # if this script is being executed, not sourced
    main
fi
