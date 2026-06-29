if not status is-interactive
    exit
end

# Make all systems behave the same as fish 4.1.0+ on macOS, i.e.
# Alt- / Option- : move around / delete word
# Ctrl- : move around / delete token
# E.g. For a token "foo-bar", "foo" and "bar" are words,
bind alt-delete kill-word
bind alt-backspace backward-kill-word
bind alt-right nextd-or-forward-word
bind alt-left prevd-or-backward-word

bind ctrl-delete kill-token
bind ctrl-backspace backward-kill-token
bind ctrl-right forward-token
bind ctrl-left backward-token

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
