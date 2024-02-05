if not status is-interactive
    exit
end

# reload (source) fish config
abbr src exec fish


# --- Files & Dirs ---

# ls
abbr l ls -ahl
if command -q eza
    abbr l eza --all --long
    abbr tree eza --tree
end

# prompt before action
abbr mv mv -i
abbr rm rm -i

# add/remove ~ (tilde) at the end of filename
function disable-file
    mv -i $argv[1] "$argv[1]"~
end
function enable-file
    mv -i $argv[1] (string replace --regex '~$' '' $argv[1])
end

# take functinos (inspired by ohmyzsh)
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/functions.zsh
function take
    if string match --quiet --regex '^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$' $argv[1]
        takeurl $argv[1]
    else if string match --quiet --regex '^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$' $argv[1]
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
    git clone $argv[1]
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
abbr e edit


# --- Per Commands ---

if command -q zellij
    # Edit zellij configs
    function zellij-config
        hx --vsplit $HOME/.config/zellij/config.kdl (zellij setup --dump-config | psub)
    end
end

