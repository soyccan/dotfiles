if not status is-interactive
    exit
end

set homebrew_prefix ''

for path in "/opt/homebrew" "/home/linuxbrew/.linuxbrew"
    if test -d $path
        set homebrew_prefix $path
        break
    end
end

if [ $homebrew_prefix = '' ]
    exit
end

set --global --export HOMEBREW_PREFIX $homebrew_prefix
set --global --export HOMEBREW_CELLAR $homebrew_prefix/Cellar
if [ $homebrew_prefix = "/home/linuxbrew/.linuxbrew" ]
    set --global --export HOMEBREW_REPOSITORY $homebrew_prefix/Homebrew
else
    set --global --export HOMEBREW_REPOSITORY $homebrew_prefix
end

fish_add_path --global --move --path $homebrew_prefix/bin $homebrew_prefix/sbin

set --path fish_complete_path $homebrew_prefix/share/fish/completions
set --path fish_complete_path $homebrew_prefix/share/fish/vendor_completions.d

# if not contains "$HOMEBREW_PREFIX/share/man" $MANPATH
#     set --global --export MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
# end

# if not contains "$HOMEBREW_PREFIX/share/info" $INFOPATH
#     set --global --export INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH
# end
