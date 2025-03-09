# --- Write configs for both interactive and non-interactive shells here ---

if not status is-interactive
    exit
end

# --- Below are for interactive shells ---

# Paths
fish_add_path $HOME/.local/bin

# Theme
set fish_color_command blue
set fish_color_option green
set fish_color_param cyan

# Nix Home Manager
# if test -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
#     fenv source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" > /dev/null
# end

# Locales
# let Nix use the system locale archive
if [ -e /usr/lib/locale/locale-archive ]
    set -x LOCALE_ARCHIVE /usr/lib/locale/locale-archive
end

# Default editor
for editor in nvim hx vim vi nano
    if command -q $editor
        set -x EDITOR (command -s $editor)
        break
    end
end
