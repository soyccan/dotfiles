if not status is-interactive
    exit
end

# fish builtins
abbr cmd command
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
    abbr tree 'eza --tree --git-ignore'
    abbr tree! 'eza --tree --all'
else
    abbr l 'ls -ahl'
end

abbr ln 'ln -s'

# prompt before action
abbr mv 'mv -iv'
abbr cp 'cp -irv'
abbr rm 'rm -iv'

# archive
abbr lzip 'unzip -l'
abbr ltar 'tar -tf'
abbr untar 'tar -xvf'

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
    argparse sudo -- $argv

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
abbr e edit
abbr se 'edit --sudo'

# View
abbr t 'tail -n 100'
abbr T 'tail -n 100 -F'


# --- System Administration ---

abbr df 'df -h'
abbr du 'du -h'
# abbr ip 'ip -color=auto'
abbr nmp 'sudo nmap -v -T4 -A -oA hostname'
abbr ping 'ping -c 5'
abbr pgrep 'pgrep -fa'
abbr pkill 'pkill -fe'

if command -q ss
    # show listening ports
    function ssl
        sudo ss --listening --tcp --udp --numeric --processes | begin
            sed --unbuffered 1q
            awk '{ split($5, arr, ":"); print arr[length(arr)] "\t" $0 }' | sort --key 1n
        end
    end
else
    # show listening ports
    abbr ssl 'netstat -ltunp'
end


# --- Per Commands ---

if command -q apt
    function apt-show
        apt show -a $argv | bat -l yaml --color=always | rg --passthru --colors 'match:bg:yellow' APT-Sources
    end
end

if command -q bat
    abbr batp 'bat --paging auto'
end

if command -q base64
    function e64
        printf %s $argv[1] | base64 --wrap=0
    end
    function d64
        printf %s $argv[1] | base64 --decode --wrap=0
    end
end

if command -q crackmapexec
    abbr cme 'crackmapexec smb'
end
if command -q netexec
    abbr nxc 'netexec smb'
end

if command -q fdfind
    abbr fd 'fdfind -gu'
end

if command -q journalctl
    abbr jc 'journalctl -xeu'
end

if command -q lazydocker
    abbr lzd lazydocker
    abbr lzp 'DOCKER_HOST=unix:///run/user/1000/podman/podman.sock lazydocker'
    abbr lzP 'DOCKER_HOST=unix:///run/podman/podman.sock sudo lazydocker'
end

if command -q lazygit
    abbr lzg lazygit
end

if command -q nft
    abbr nftl 'sudo nft --handle list ruleset'
end

if command -q podman
    abbr pm podman
end

if command -q python3
    abbr py python3
    abbr pyhttp 'python3 -m http.server 80'
    abbr ipy 'python3 -m IPython'
    abbr pt 'python3 -m poetry'
    abbr ve 'python3 -m venv .venv'
    abbr vea 'source .venv/bin/activate.fish'
end

if command -q rsync
    abbr rsync-copy 'rsync -ah --info=progress2'
    abbr rsync-move 'rsync -ah --info=progress2 --remove-source-files'
    abbr rsync-update 'rsync -ahu --info=progress2'
    abbr rsync-synchronize 'rsync -ahu --info=progress2 --delete'
end

if command -q systemctl
    abbr sc systemctl
    abbr scc 'systemctl cat'
    abbr scd 'sudo systemctl disable --now'
    abbr scdr 'sudo systemctl daemon-reload'
    abbr sce 'sudo systemctl enable --now'
    abbr scf 'systemctl --failed'
    abbr scr 'sudo systemctl restart'
    abbr scs 'systemctl status'
    abbr scu 'systemctl --user'
    abbr scx 'sudo systemctl stop'
end

if command -q tig
    abbr tiga 'tig --all'
end

if command -q ufw
    abbr ufwl 'sudo ufw status verbose'
end

if command -q zellij
    abbr za 'zellij attach'
    abbr zj zellij
    abbr zjc zellij-config
    abbr zjl 'zellij list-sessions'
    abbr zjy zellij-layout

    function zellij-config --description 'edit zellij config (with the default config aside)'
        edit (get-default XDG_CONFIG_HOME $HOME/.config)/zellij/config.kdl (zellij setup --dump-config | psub)
    end

    function zellij-layout --description 'edit zellij default layout'
        edit $XDG_CONFIG_HOME/zellij/layouts/default.kdl (zellij setup --dump-layout default | psub)
    end
end
