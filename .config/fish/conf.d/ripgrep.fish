if command -q rg
    set -x RIPGREP_CONFIG_PATH (get-default XDG_CONFIG_HOME $HOME/.config)/ripgrep/config
end
