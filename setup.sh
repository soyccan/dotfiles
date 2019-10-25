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
               "$HOME/.config/nvim"
    fi
    exit
fi

base="$(pwd)/$(dirname $0)"

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
git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search $ZSH/custom/plugins/zsh-history-substring-search


# oh-my-tmux
echo Installing Oh My TMUX
git clone --depth 1 https://github.com/gpakosz/.tmux "$HOME/.tmux"
ln -s "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$base/tmux.conf.local" "$HOME/.tmux.conf.local"



# vim
echo Installing VIM
ln -s "$base/vim" "$HOME/.vim"
ln -s "$base/vim" "$HOME/.config/nvim"



echo Voila! Setup Finished!
