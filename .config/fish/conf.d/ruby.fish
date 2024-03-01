if not status is-interactive
    exit
end

for path in (get-default XDG_DATA_HOME $HOME/.local/share)/gem/ruby/*
    if test -d $path/bin
        fish_add_path $path/bin
    end
end
