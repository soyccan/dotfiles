#!/bin/sh
set -eux
IFS=

if [ $EUID -ne 0 ]; then
    echo "Error: Require privilege"
    exit 1
fi

${EDITOR:-vim} /etc/nixos/configuration.nix /etc/nixos/flake.nix
alejandra /etc/nixos/configuration.nix /etc/nixos/flake.nix
if [ -z "$(git -C /etc/nixos --no-pager diff --unified=0 *.nix)" ]; then
    echo "No change. Quitting..."
    exit 1
fi

echo "Updating flake.lock"
nix flake update --flake /etc/nixos

echo "NixOS rebuilding..."
git -C /etc/nixos add --update configuration.nix flake.nix flake.lock
if ! nixos-rebuild switch --flake /etc/nixos &> /var/log/nixos-rebuild.log; then
    echo "Build failed. See /var/log/nixos-rebuild.log"
    grep --color error /var/log/nixos-rebuild.log
    exit 1
fi

gen=$(nixos-rebuild list-generations | grep current)
git -C /etc/nixos commit --message "$gen"
