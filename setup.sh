#!/bin/bash

dotfiles="$(dirname "$(readlink -f "$0")")"


has() {
    type "$1" >/dev/null 2>&1
}

log() {
    echo "$0: $@"
}

remove_with_backup() {
    if [[ ! -e "$1" ]]; then
        return
    fi

    name="$1"~
    while [[ -e "$name" ]]; do
        name="$name"~
    done
    mv -iv "$1" "$name"
}

ln_safe() {
    target="$1"
    link="$2"
    mkdir -p "$(dirname "$link")"
    if [[ -L "$link" ]]; then
        # if $link is a symbolic link, replace it
        ln -svnf "$target" "$link"
    else
        # otherwise, make a backup before overwriting
        remove_with_backup "$link"
        ln -svni "$target" "$link"
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

    log Installing package "$1"

    if has apt; then
        "$sudo" apt install -y "$1"
    elif has yum; then
        "$sudo" yum install -y "$1"
    elif has brew; then
        brew install "$1"
    fi
}


setup_zsh() {
    log Configuring ZSH

    if ! has zsh; then
        log Installing standalone version of ZSH
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh-bin/master/install)"
    fi

    if sudo -l && [[ -x /bin/zsh ]]; then
        log Setting default shell to ZSH
        sudo usermod "$USER" -s /bin/zsh
    fi

    log Linking ZSH config files

    # config files
    ln_safe "$dotfiles/zsh/zshrc" "$HOME/.zshrc"
    ln_safe "$dotfiles/zsh" "$HOME/.config/zsh"

    # powerlevel10k
    ln_safe "$dotfiles/zsh/p10k.zsh" "$HOME/.p10k.zsh"
}


setup_fish() {
    echo Configuring FISH

    if [[ "$(awk -F':' "/^$USER/ { print \$7 }" /etc/passwd)" != '/bin/fish' ]]; then
        sudo usermod "$USER" -s /bin/fish
    fi

    # oh-my-fish
    # curl -L https://get.oh-my.fish | fish

    # fisher
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
}


setup_tmux() {
    log Configuring TMUX

    # oh-my-tmux
    log Installing Oh My TMUX
    ln_safe "$dotfiles/tmux/oh-my-tmux" "$HOME/.tmux"
    ln_safe "$dotfiles/tmux/oh-my-tmux/.tmux.conf" "$HOME/.tmux.conf"
    ln_safe "$dotfiles/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"
}


setup_vim() {
    log Configuring Vim

    # neovim configurations
    ln_safe "$dotfiles/vim" "$HOME/.config/nvim"

    # vim-plug
    curl -fL --create-dirs \
         -o "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # compatible with vim
    ln_safe "$dotfiles/vim" "$HOME/.vim"
    ln_safe "$dotfiles/vim/init.vim" "$HOME/.vimrc"
}


setup_gdb() {
    log Configuring GDB

    ln_safe "$dotfiles/gdb" "$HOME/.gdb"
    ln_safe "$dotfiles/gdb/gdbinit" "$HOME/.gdbinit"
    ln_safe "$dotfiles/gdb/lldbinit" "$HOME/.lldbinit"
}


setup_git() {
    log Configuring Git
    ln_safe "$dotfiles/git/gitconfig" "$HOME/.gitconfig"
    ln_safe "$dotfiles/git/template" "$HOME/.git_template"
}


main() {
    setup_tmux
    setup_zsh
    setup_vim
    setup_git
    log Voila! Setup Finished!
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    # if this script is being executed, not sourced
    main
fi
