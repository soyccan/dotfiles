#!/bin/bash


dotfiles="$(dirname "$(readlink -f "$0")")"


has() {
    type "$1" >/dev/null 2>&1
}

ln_confirm() {
    src="$1"
    link="$2"
    mkdir -p "$(dirname "$link")"
    if [ -L "$link" ]; then
        # if $link is a symbolic link, replace it
        rm "$link"
        ln -sv "$src" "$link"
    else
        # otherwise, ask for overwriting
        ln -svi "$src" "$link"
    fi
}

install_pkg() {
    if has "$1"; then
        return
    fi

    sudo=
    if has sudo; then
        sudo=sudo
    fi

    if has apt; then
        "$sudo" apt install -y "$1"
    elif has yum; then
        "$sudo" yum install -y "$1"
    elif has brew; then
        brew install "$1"
    fi
}


setup_zsh() {
    echo Configuring ZSH

    # standalone version of zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh-bin/master/install)"

    if [ -x /bin/zsh ]; then
        sudo usermod "$USER" -s /bin/zsh
    fi

    # config files
    ln_confirm "$dotfiles/zsh/zshrc" "$HOME/.zshrc"
    ln_confirm "$dotfiles/zsh" "$HOME/.config/zsh"

    # powerlever10k
    ln_confirm "$dotfiles/zsh/p10k.zsh" "$HOME/.p10k.zsh"
}


setup_fish() {
    echo Configuring FISH

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

    # oh-my-tmux
    echo Installing Oh My TMUX
    ln_confirm "$dotfiles/tmux/oh-my-tmux" "$HOME/.tmux"
    ln_confirm "$dotfiles/tmux/oh-my-tmux/.tmux.conf" "$HOME/.tmux.conf"
    ln_confirm "$dotfiles/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"
}


setup_vim() {
    echo Configuring Vim

    # neovim configurations
    ln_confirm "$dotfiles/vim" "$HOME/.config/nvim"

    # vim-plug
    curl -fL --create-dirs \
         -o "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # compatible with vim
    ln_confirm "$dotfiles/vim" "$HOME/.vim"
    ln_confirm "$dotfiles/vim/init.vim" "$HOME/.vimrc"
}


setup_gdb() {
    echo Configuring GDB

    ln_confirm "$dotfiles/gdb" "$HOME/.gdb"
    ln_confirm "$dotfiles/gdb/gdbinit" "$HOME/.gdbinit"
    ln_confirm "$dotfiles/gdb/lldbinit" "$HOME/.lldbinit"
}


setup_git() {
    echo Configuring Git
    ln_confirm "$dotfiles/git/gitconfig" "$HOME/.gitconfig"
}


main() {
    setup_tmux
    setup_zsh
    setup_vim
    setup_git
    echo Voila! Setup Finished!
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    # if this script is being executed, not sourced
    main
fi
