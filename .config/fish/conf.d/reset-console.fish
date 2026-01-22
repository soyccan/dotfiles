# Clean up mouse mode activated by tmux which may fail to restore
# when remote session aborts ungracefully (like network disconnection)
# \e[?1000l: X11 mouse reporting
# \e[?1002l: Button-event tracking
# \e[?1003l: Any-event tracking
# \e[?1006l: SGR extended mouse mode
# \e[?1049l \e[?47l: Quit alternate screen buffer
# \e[?1h: Hide cursor
# \e=: Quit application keyboard mode
# stty sane:
# Details on `man console_codes`
function __reset_console_on_prompt --on-event fish_prompt
    printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l' 2>/dev/null
end
