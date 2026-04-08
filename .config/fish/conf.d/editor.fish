if not status is-interactive
    exit
end

# Default editor
for editor in nvim hx vim vi nano
    if command -q $editor
        set -x EDITOR (command -s $editor)
        break
    end
end
