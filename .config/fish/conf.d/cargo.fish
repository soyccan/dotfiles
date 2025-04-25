if not status is-interactive || not test -d "$HOME/.cargo/bin"
    exit
end

fish_add_path --global "$HOME/.cargo/bin"

abbr ca 'cargo add'
abbr ca! 'cargo add --no-default-features --features'
abbr cb 'cargo build'
abbr cf 'cargo feature'
abbr cg 'cargo'
abbr cnt 'cargo nextest run'
abbr cr 'cargo run'
abbr ct 'cargo test'
