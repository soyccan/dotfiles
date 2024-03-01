if not status is-interactive
    exit
end

if test -d $HOME/.foundry/bin
    fish_add_path $HOME/.foundry/bin
end
