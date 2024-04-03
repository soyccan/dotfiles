function brew-up
    echo 'Installing Homebrew on your system...'
    bash (curl --proto '=https' --tlsv1.2 -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' | psub)
end
