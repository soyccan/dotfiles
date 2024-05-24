if not status is-interactive
    exit
end

if test -d $HOME/.local/share/foundry/bin
    fish_add_path $HOME/.local/share/foundry/bin
end

if test -d $HOME/.foundry/bin
    fish_add_path $HOME/.foundry/bin
end
