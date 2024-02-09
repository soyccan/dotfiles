if not status is-interactive
    exit
end

set -U XDG_CONFIG_HOME $HOME/.config

# fish builtins
abbr cmd 'command'
abbr which 'command -s'
abbr where 'type -a'

# reload (source) fish config
abbr src 'exec fish'


# --- Files & Dirs ---

# ls
if command -q eza
    alias l 'eza --all --all --long --time-style=iso --binary --git'
    abbr tree 'eza --tree'
else
    abbr l 'ls -ahl'
end

# prompt before action
abbr mv 'mv -i'
abbr rm 'rm -i'

# add/remove ~ (tilde) at the end of filename
function disable-file
    for file in $argv
        mv -i $file "$file"~
    end
end
function enable-file
    for file in $argv
        mv -i $file (string replace --regex '~$' '' $file)
    end
end

# take functinos (inspired by ohmyzsh)
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/functions.zsh
function take
    if string match --quiet --regex '\.(tar\.(gz|bz2|xz)|t[gbx]z)$' $argv[1]
        takeurl $argv[1]
    else if string match --quiet --regex '\.git/?$' $argv[1]
        takegit $argv[1]
    else
        takedir $argv
    end
end
function takedir
    mkdir -p $argv && cd $argv[-1]
end
function takeurl
    set tmpfile (mktemp)
    curl -Lo $tmpfile $argv[1]
    set dirname (tar -tf $tmpfile | head -n 1)
    tar -xf $tmpfile
    rm $tmpfile
    cd $dirname
end
function takegit
    git clone --recurse-submodules --depth 1 $argv[1]
    string match --quiet --regex '^.*/(?<repo>.*)\.git$' $argv[1]
    if not set -q repo
        echo "Error: dir '$repo' does not exist"
        return 1
    end
    cd $repo
end

# Edit
function edit --description 'edit files in vsplit windows'
    switch $EDITOR
        case hx
            $EDITOR --vsplit $argv
        case nvim vim vi
            $EDITOR -O $argv
    end
end
abbr e 'edit'


# --- Per Commands ---

if command -q systemctl
    abbr sc 'systemctl'
    abbr scs 'systemctl status'
    abbr scst 'sudo systemctl start'
    abbr scstp 'sudo systemctl stop'
    abbr sce 'sudo systemctl enable --now'
    abbr scd 'sudo systemctl disable --now'
end

if command -q tig
    abbr tiga 'tig --all'
end

if command -q zellij
    function zellij-config --description 'edit zellij config (with the default config aside)'
        edit $XDG_CONFIG_HOME/zellij/config.kdl (zellij setup --dump-config | psub)
    end
end

