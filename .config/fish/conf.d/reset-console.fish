# Clean up mouse mode activated by tmux which may fail to restore
# when remote session aborts ungracefully (like network disconnection)
# 1000: X11 mouse reporting
# 1002: Button-event tracking
# 1003: Any-event tracking
# 1006: SGR extended mouse mode
# Details on `man console_codes`
function __reset_console_on_prompt --on-event fish_prompt
    printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l' 2>/dev/null
end
