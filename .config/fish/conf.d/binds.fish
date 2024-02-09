if not status is-interactive
    exit
end

# Alt-Delete
bind \e\[3\;3~ kill-word

if command -q zoxide
    bind \cg __zoxide_zi 'commandline -f repaint'
end

if command -q fzf
    bind \ct fzf-file-widget
    bind \cr fzf-history-widget
    bind \ec fzf-cd-widget  # Alt-c

    if bind -M insert > /dev/null 2>&1
        bind -M insert \ct fzf-file-widget
        bind -M insert \cr fzf-history-widget
        bind -M insert \ec fzf-cd-widget
    end
end
