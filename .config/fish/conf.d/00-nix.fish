if not status is-interactive || not test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    exit
end

source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'

# Nix Home Manager
# if test -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
#     fenv source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" > /dev/null
# end

# Locales
# let Nix use the system locale archive
if [ -e /usr/lib/locale/locale-archive ]
    set -x LOCALE_ARCHIVE /usr/lib/locale/locale-archive
end
