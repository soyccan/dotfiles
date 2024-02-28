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

# cd
abbr - 'cd -'
abbr ... 'cd ../..'
abbr ..2 'cd ../..'
abbr ..3 'cd ../../..'
abbr ..4 'cd ../../../..'
abbr ..5 'cd ../../../../..'

# ls
if command -q eza
    alias l 'eza --all --all --long --time-style=iso --binary --git'
    abbr tree 'eza --tree'
else
    abbr l 'ls -ahl'
end

abbr ln 'ln -s'

# prompt before action
abbr mv 'mv -i'
abbr cp 'cp -ir'
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
    argparse 'sudo' -- $argv

    set editor_path (string split '/' $EDITOR)
    switch $editor_path[-1]
        case hx
            if test $_flag_sudo
                command sudo $EDITOR --vsplit $argv
            else
                command $EDITOR --vsplit $argv
            end
        case nvim vim vi
            if test $_flag_sudo
                command sudo $EDITOR -O $argv
            else
                command $EDITOR -O $argv
            end
    end
end
abbr e 'edit'
abbr se 'edit --sudo'

# View
abbr t 'tail -n 100'
abbr T 'tail -n 0 -F'


# --- System Administration ---
abbr df 'df -h'
abbr du 'du -h'
abbr ip 'ip -color=auto'
abbr ping 'ping -c 5'


# --- Per Commands ---

if command -q apt
    function apt-show
        apt show -a $argv | \
            bat -l yaml --color=always | \
            rg --passthru --colors 'match:bg:yellow' APT-Sources
    end
end

if command -q nft
    abbr nftl 'sudo nft --handle list ruleset'
end

if command -q journalctl
    abbr jc 'journalctl -xeu'
end

if command -q ufw
    abbr ufwl 'sudo ufw status verbose'
end

if command -q systemctl
    abbr sc 'systemctl'
    abbr scr 'sudo systemctl restart'
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
    abbr za 'zellij attach'
    abbr zj 'zellij'
    abbr zjc 'zellij-config'
    abbr zjl 'zellij list-sessions'
    abbr zjy 'zellij-layout'

    function zellij-config --description 'edit zellij config (with the default config aside)'
        edit $XDG_CONFIG_HOME/zellij/config.kdl (zellij setup --dump-config | psub)
    end

    function zellij-layout --description 'edit zellij default layout'
        edit $XDG_CONFIG_HOME/zellij/layouts/default.kdl (zellij setup --dump-layout default | psub)
    end
end
