if not status is-interactive
    exit
end

fish_add_path --global $HOME/.foundry/bin

if [ -e $HOME/.foundry/bin ] && [ -e $HOME/.config/foundry.toml ]
    set -x FOUNDRY_CONFIG $HOME/.config/foundry.toml
end
