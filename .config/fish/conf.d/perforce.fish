if not status is-interactive || not command -q p4
    exit
end

set -x P4CONFIG $HOME/.p4config
