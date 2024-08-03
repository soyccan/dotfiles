local wezterm = require "wezterm"
local act = wezterm.action

local config = {
    --- Control ---

    keys = {
        {
            key = 'F',
            mods = 'CTRL|SHIFT',
            action = act.Search {
                CaseInSensitiveString = ""
            },
        },
    },

    --- Appearance ---

    font = wezterm.font_with_fallback {
        "Fira Code",
        "Cascadia Code",
        "JetBrains Mono",
        "Hack",
        "DejaVu Sans Mono",
        "Noto Sans Mono",
        "Monaco",
        "Inconsolata",
        "Consolas",
        "Lucida Console",
        "Courier New",
        "monospace",
    },
    font_size = 10,

    bold_brightens_ansi_colors = "No",

    -- Solarized: https://github.com/altercation/solarized
    -- SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      RGB         HSB
    -- --------- ------- ---- -------  ----------- ---------- ----------- -----------
    -- base03    #002b36  8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21
    -- base02    #073642  0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26
    -- base01    #586e75 10/7 brgreen  240 #585858 45 -07 -07  88 110 117 194  25  46
    -- base00    #657b83 11/7 bryellow 241 #626262 50 -07 -07 101 123 131 195  23  51
    -- base0     #839496 12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59
    -- base1     #93a1a1 14/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63
    -- base2     #eee8d5  7/7 white    254 #e4e4e4 92 -00  10 238 232 213  44  11  93
    -- base3     #fdf6e3 15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99
    -- yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
    -- orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
    -- red       #dc322f  1/1 red      160 #d70000 50  65  45 220  50  47   1  79  86
    -- magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
    -- violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
    -- blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
    -- cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
    -- green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60

    --- Solarized Dark ---
    -- base3: bright white
    -- base2: white
    -- base1: optional emphasized content
    -- base0: body text / default code / primary content
    -- base00
    -- base01: comments / secondary content
    -- base02: background highlights
    -- base03: background

    colors = {
        foreground = "#839496", -- base0
        background = "#002b36", -- base03

        cursor_fg = "#002b36", -- base03
        cursor_bg = "#839496", -- base0
        cursor_border = "#839496", -- base0

        selection_bg = "#586e75", -- base01

        ansi = {
            "#002b36", -- black (base03)
            "#dc322f", -- red
            "#859900", -- green
            "#b58900", -- yellow
            "#268bd2", -- blue
            "#d33682", -- magenta
            "#2aa198", -- cyan
            "#eee8d5", -- white (base2)
        },

        brights = {
            "#586e75", -- black (base01)
            "#cb4b16", -- orange
            "#859900", -- green
            "#b58900", -- yellow
            "#268bd2", -- blue
            "#6c71c4", -- violet
            "#2aa198", -- cyan
            "#fdf6e3", -- white (base3)
        },
    },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    -- Windows-specific settings
    config.default_prog = { "powershell.exe" }

elseif wezterm.target_triple == "x86_64-apple-darwin" then
    -- macOS-specific settings

elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
    -- Linux-specific settings

end

return config
