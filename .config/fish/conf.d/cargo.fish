if not status is-interactive
    exit
end

if test -d $HOME/.cargo/bin
    fish_add_path $HOME/.cargo/bin

    abbr ca 'cargo add'
    abbr cb 'cargo build'
    abbr cg 'cargo'
    abbr cr 'cargo run'
end
