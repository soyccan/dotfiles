if not status is-interactive
    exit
end

function semver_cmp
    set vers1 $argv[1]
    set vers2 $argv[2]
    set parts1 (string split '.' $vers1)
    set parts2 (string split '.' $vers2)
    for i in (seq 1 3)
        set -q parts1[$i] || set parts1[$i] 0
        set -q parts2[$i] || set parts2[$i] 0
        if [ $parts1[$i] -lt $parts2[$i] ]
            echo -1
            return
        else if [ $parts1[$i] -gt $parts2[$i] ]
            echo 1
            return
        end
    end
    echo 0
    return
end
function semver_lt
    [ (semver_cmp $argv) -lt 0 ]
end
function semver_le
    [ (semver_cmp $argv) -le 0 ]
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
    function __override_alias_l --on-event fish_prompt --description "override system-wide alias at fish prompt since user config is sourced prior to system config"
        abbr -e l
        functions -e l
        alias l 'eza --all --all --long --time-style=iso --binary --git'
    end
    abbr tree 'eza --tree --long --time-style=iso --git-ignore'
    abbr tree! 'eza --tree --long --time-style=iso --all'
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
abbr lzv 'NVIM_APPNAME=lazyvim nvim'

# View
abbr t 'tail -n 100'
abbr T 'tail -n 100 -F'

function watchex --description "Watch & execute when a Python file changes"
    while true
        inotifywait $argv[1] || break
        python3 $argv[1]
    end
end


# --- System Administration ---

abbr chown! 'sudo chown -R (id -u):(id -g) .'
abbr df 'df -h'
abbr du 'du -h'
if command -q ip
    set iproute_version (dpkg -l iproute2 | perl -ne 'print $1 if /iproute2\s*(\d+\.\d+\.\d+)/')
    if semver_lt $iproute_version '6.7.0'
        abbr ip 'ip -c' # color
    end
end
abbr iost 'iostat -Nxz --human --pretty --compact 2'
abbr lsb 'lsblk -o NAME,TYPE,FSTYPE,LABEL,SIZE,FSUSED,FSAVAIL,FSUSE%,MOUNTPOINTS | grep -v loop'
abbr nmp 'sudo nmap -v -T4 -sC -sV -oA hostname'
abbr ping 'ping -c 5'
abbr pgrep 'pgrep -fa'
abbr pkill 'pkill -fe'
abbr ssh! 'ssh -o StrictHostKeychecking=no'
abbr scp! 'scp -o StrictHostKeychecking=no'

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
    abbr fd 'fdfind -u'
else if command -q fd
    abbr fd 'fd -u'
end

if command -q journalctl
    abbr jc 'journalctl -xeu'
    abbr jcf 'journalctl -xfu'
    abbr jcu 'journalctl --user -xeu'
    abbr jcuf 'journalctl --user -xfu'
end

if command -q lazydocker
    abbr lzd lazydocker
    abbr lzp 'DOCKER_HOST=unix:///run/user/1000/podman/podman.sock lazydocker'
    abbr lzP 'sudo env DOCKER_HOST=unix:///run/podman/podman.sock lazydocker'
end

if command -q lazygit
    abbr lzg lazygit
    abbr lzy 'lazygit --work-tree ~ --git-dir ~/.local/share/yadm/repo.git/'
end

if command -q nft
    abbr nftl 'sudo nft --handle list ruleset'
end

if command -q nix
    abbr nxr 'nix run nixpkgs#'
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
    abbr sced 'sudo systemctl edit'
    abbr scf 'systemctl --failed'
    abbr scr 'sudo systemctl restart'
    abbr scs 'systemctl status'
    abbr scx 'sudo systemctl stop'

    abbr scu 'systemctl --user'
    abbr scuc 'systemctl --user cat'
    abbr scud 'systemctl --user disable --now'
    abbr scudr 'systemctl --user daemon-reload'
    abbr scue 'systemctl --user enable --now'
    abbr scued 'systemctl --user edit'
    abbr scuf 'systemctl --user --failed'
    abbr scur 'systemctl --user restart'
    abbr scus 'systemctl --user status'
    abbr scux 'systemctl --user stop'
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
