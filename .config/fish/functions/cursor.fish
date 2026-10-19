# Autoload as ~/.config/fish/functions/cursor.fish.
# Local files use IPC; --wait/-w waits for closure. Other CLI arguments and
# remote sessions are delegated unchanged. `command cursor` bypasses this.
function cursor --description 'Open local files through Cursor IPC'
    /Users/zacc/.local/bin/cursor-fast $argv
end
