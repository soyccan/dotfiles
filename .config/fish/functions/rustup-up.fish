function rustup-up
    echo 'Installing Rustup on your system...'
    sh (curl --proto '=https' --tlsv1.2 -fsSL 'https://sh.rustup.rs' | psub) \
        --component rust-analyzer \
        --default-toolchain nightly \
        --no-modify-path
end
