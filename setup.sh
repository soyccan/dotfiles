#!/bin/sh

if [ "$1" = 'clean' ]; then
    echo 'Are you sure? (yes)'
    read ans
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
    . /etc/os-release
    if [ "$NAME" = "CentOS Linux" ]; then
        echo yum
    elif [ "$NAME" = "Ubuntu" ]; then
        echo apt
    fi
)
pkgmgr=$(get_package_manager)


dotfiles="$(pwd)/$(dirname $0)"


#######
# zsh #
#######

# zsh
if ! which zsh >/dev/null; then
    echo Installing ZSH
    sudo $pkgmgr install zsh
    sudo usermod $USER -s /bin/zsh
fi

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


########
# tmux #
########

# oh-my-tmux
echo Installing Oh My TMUX
git clone --depth 1 https://github.com/gpakosz/.tmux "$HOME/.tmux"
ln_confirm "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
ln_confirm "$dotfiles/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"


#######
# vim #
#######

echo Installing VIM
ln_confirm "$dotfiles/vim" "$HOME/.vim"
ln_confirm "$dotfiles/vim" "$HOME/.config/nvim"
ln_confirm "$dotfiles/vim/init.vim" "$HOME/.vimrc"
ln_confirm "$dotfiles/vim/init.vim" "$HOME/.vimrc"


#######
# gdb #
#######

echo Setup GDB
mkdir "$HOME/.gdb"
git clone --depth 1 https://github.com/longld/peda "$HOME/.gdb/peda"
git clone --depth 1 https://github.com/pwndbg/pwndbg "$HOME/.gdb/pwndbg"
git clone --depth 1 https://github.com/scwuaptx/Pwngdb "$HOME/.gdb/Pwngdb"
git clone --depth 1 https://github.com/cloudburst/libheap "$HOME/.gdb/libheap"
ln_confirm "$dotfiles/gdb/gdbinit" "$HOME/.gdbinit"

# lldb
ln_confirm "$dotfiles/gdb/lldbinit" "$HOME/.lldbinit"


########
# Done #
########

echo Voila! Setup Finished!
