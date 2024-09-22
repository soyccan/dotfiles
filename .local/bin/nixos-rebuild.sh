#!/bin/sh
set -e
if [[ $EUID -ne 0 ]]; then
    echo "Error: Require privilege"
    false
fi
cd /etc/nixos
${EDITOR:-vim} flake.nix configuration.nix
alejandra .
git diff -U0 *.nix
echo "NixOS rebuilding..."
if ! nixos-rebuild switch &> /var/log/nixos-rebuild.log; then
    grep --color error /var/log/nixos-rebuild.log
    false
fi
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
