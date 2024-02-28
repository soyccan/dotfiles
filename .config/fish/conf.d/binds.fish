if not status is-interactive
    exit
end

# Alt-Delete
bind \e\[3\;3~ kill-word

if command -q zoxide
    # Ctrl-g: goto recent dir
    bind \cg __zoxide_zi 'commandline -f repaint'
end

if command -q fzf
    # Ctrl-t: find files in dir tree
    bind \ct fzf-file-widget

    # Ctrl-r: find command history
    bind \cr fzf-history-widget

    # Alt-c: find dir in dir tree
    bind \ec fzf-cd-widget

    # Ctrl-q: insert recent file
    bind \cq fzf-fasd-widget

    # if bind -M insert > /dev/null 2>&1
    #     bind -M insert \ct fzf-file-widget
    #     bind -M insert \cr fzf-history-widget
    #     bind -M insert \ec fzf-cd-widget
    # end
end
