if not status is-interactive
    exit
end

if test -d "/opt/homebrew"
    set --global --export HOMEBREW_PREFIX "/opt/homebrew"
    set --global --export HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set --global --export HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX"
else if test -d "/home/linuxbrew/.linuxbrew"
    set --global --export HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
    set --global --export HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set --global --export HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
else
    exit
end

fish_add_path --global --move --path "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"

# if not contains "$HOMEBREW_PREFIX/share/man" $MANPATH
#     set --global --export MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
# end

# if not contains "$HOMEBREW_PREFIX/share/info" $INFOPATH
#     set --global --export INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH
# end
