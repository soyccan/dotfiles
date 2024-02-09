# --- Write configs for both interactive and non-interactive shells here ---

if not status is-interactive
    exit
end

# --- Below are for interactive shells ---

# universal variables inherit environment variables, and provide default values if missing
set -U XDG_CONFIG_HOME $HOME/.config

# Nix Home Manager
# if test -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
#     fenv source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" > /dev/null
# end

# Locales
# let Nix use the system locale archive
set -x LOCALE_ARCHIVE /usr/lib/locale/locale-archive

# Default editor
for editor in hx nvim vim vi nano
    if command -q $editor
        set -x EDITOR $editor
        break
    end
end

# --- Per Commands ---

if command -q rg
    set -x RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/config
end
