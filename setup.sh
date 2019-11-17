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

base="$(pwd)/$(dirname $0)"

get_package_manager() {
    . /etc/os-release
    if [ "$NAME" = "CentOS Linux" ]; then
        echo yum
    elif [ "$NAME" = "Ubuntu" ]; then
        echo apt
    fi
}
pkgmgr=$(get_package_manager)


## zsh
echo Installing ZSH
sudo $pkgmgr install zsh
sudo usermod $USER -s /bin/zsh

# oh-my-zsh
echo Installing Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s "$base/zsh/alias.zsh" "$HOME/.oh-my-zsh/custom/alias.zsh"
ln -sf "$base/zsh/zshrc" "$HOME/.zshrc"

# download third-party plugins
git clone --depth 1 https://github.com/Powerlevel9k/powerlevel9k $ZSH/custom/themes/powerlevel9k
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-completions $ZSH/custom/plugins/zsh-completions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting $ZSH/custom/plugins/zsh-syntax-highlighting



## oh-my-tmux
echo Installing Oh My TMUX
git clone --depth 1 https://github.com/gpakosz/.tmux "$HOME/.tmux"
ln -s "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$base/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"



## vim
echo Installing VIM
ln -sf "$base/vim" "$HOME/.vim"
ln -sf "$base/vim" "$HOME/.config/nvim"


## gdb
echo Setup GDB
mkdir "$HOME/.gdb"
git clone --depth 1 https://github.com/longld/peda "$HOME/.gdb/peda"
git clone --depth 1 https://github.com/pwndbg/pwndbg "$HOME/.gdb/pwndbg"
ln -sf "$base/gdb/gdbinit" "$HOME/.gdbinit"
printf '#!/bin/sh\nexec gdb -q -ex init-peda "$@"'   | sudo tee /usr/local/bin/peda   >/dev/null
printf '#!/bin/sh\nexec gdb -q -ex init-pwndbg "$@"' | sudo tee /usr/local/bin/pwndbg >/dev/null
sudo chmod +x /usr/local/bin/peda
sudo chmod +x /usr/local/bin/pwndbg

ln -sf "$base/gdb/lldbinit" "$HOME/.lldbinit"



echo Voila! Setup Finished!
