function foundryup-up
    echo 'Installing Foundryup on your system...'
    bash (curl --proto '=https' --tlsv1.2 -fsSL 'https://foundry.paradigm.xyz' | psub)
end
