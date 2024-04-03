function pyenv-up
    echo 'Installing Pyenv on your system...'
    sh (curl --proto '=https' --tlsv1.2 -fsSL 'https://pyenv.run' | psub)
end
