if not status is-interactive || not command -q podman
    exit
end

podman completion fish | source
