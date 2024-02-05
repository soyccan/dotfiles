# --- Write configs for both interactive and non-interactive shells here ---

if not status is-interactive
    exit
end

# --- Below are configs for interactive shells ---

# Nix Home Manager
# if test -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
#     fenv source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" > /dev/null
# end

# Default editor
for editor in hx nvim vim vi nano
    if command --search $editor > /dev/null
        set --export EDITOR $editor
        break
    end
end
