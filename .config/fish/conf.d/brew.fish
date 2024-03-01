if not status is-interactive || not test -d '/opt/homebrew'
    exit
end

set -x HOMEBREW_PREFIX '/opt/homebrew'
set -x HOMEBREW_CELLAR '/opt/homebrew/Cellar'
set -x HOMEBREW_REPOSITORY '/opt/homebrew'

set -x MANPATH '/opt/homebrew/share/man' $MANPATH
set -x INFOPATH '/opt/homebrew/share/info' $INFOPATH

fish_add_path '/opt/homebrew/bin' '/opt/homebrew/sbin'
