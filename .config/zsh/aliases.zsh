# system commands
alias cp='cp -irv' # --interactive --recursive --verbose
alias mv='mv -iv' # --interactive --verbose
alias rm='rm -i' # --interactive=always
alias src='exec zsh' # reload shell

alias df='df -h' # --human-readable
alias du='du -h'  # --human-readable --apparent-size(-A) ; -A connot be used in macOS
alias free='free -h' # --human

alias ctar='tar -vcf' # create
alias ltar='tar -vtf' # list files
alias untar='tar -vxf' # extract
alias lzip='unzip -lv'
alias lrar='unrar l'

has batcat && ! has bat && bat() { batcat "$@"; }
if type bat >/dev/null; then
    # if bat exists as a command or a function
    batf() {
        local file="$1"
        shift
        tail -f "$file" | bat --paging=never --file-name="$file" "$@"
    }
fi

alias less='less -RFi' # -R: reads color codes; -i: ignore case
alias ln='ln -s' # --symbolic
alias wget='wget -c' # --continue; (--timestamping)
alias hd='hexdump -C' # hex+ascii

alias cl='clang'
alias cll='clang++'

if has python3; then
    alias py='python3'
    alias ipy='python3 -m IPython'
fi

# vim
if has nvim; then
    alias vi='nvim'
    alias vim='nvim'
    alias vimdiff='nvim -d'
fi

# git
if has git; then
    # overwrite ohmyzsh git plugin:
    # https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

    alias gb='git branch -avv'
    alias gbk=git-backup
    alias gcl='git clone'
    alias gcl1='git clone --depth 1'

    # git checkout is being replaced by git restore & git switch
    unalias gco &> /dev/null
    unalias gcor &> /dev/null
    unalias gcb &> /dev/null
    unalias gcd &> /dev/null
    unalias gcm &> /dev/null

    alias gf='git fetch --all'
    alias gr='git remote -v'
    alias grb='git rebase --rebase-merges'
    alias grbi='git rebase --rebase-merges --interactive'
    alias grbir='git rebase --rebase-merges --interactive --root'
    alias gsa='git submodule add'
    alias gsti='git status --ignored'
    alias gswd='git switch --detach'

    git() {
        # hooks to prevent dangerous commands

        if [ "$1" = reset ] && [ "$2" = --hard ] &&
            [ "$(command git status --short --untracked-files=no)" ]
        then
            echo "\"git reset --hard\" is dangerous, don't do that!"
            echo "Consider backing up & dropping local changes using \"git stash\""
            return 1
        fi

        if [ "$1" = restore ] && [ "$2" != --worktree ] &&
            [ "$(command git diff --diff-filter=M --name-only -- "$2")" ]
        then
            shift
            echo "\"git restore\" discards local changes of specified files: $*"
            echo "If you are sure want to proceed, type \"git restore --worktree\""
            return 1
        fi

        command git "$@"
    }
    git-backup() {
        if [ "$(git stash)" != 'No local changes to save' ]; then
            git stash apply
        fi
    }
    git-add-downstream() {
        git remote rename origin upstream
        git remote add origin "$1"
    }
    git-fastswitch() {
        if [ "$(git stash)" != 'No local changes to save' ]; then
            git switch "$@"
            git stash pop
        else
            git switch "$@"
        fi
    }
    git-lazypull() {
        # git pull without switching branch
        if [ $# = 1 ]; then
            repo=origin
            refspec="$1"
        else
            repo="$1"
            refspec="$2"
        fi
        git fetch "$repo" "$refspec"
        git update-ref "refs/heads/$refspec" "$repo/$refspec"
    }
    git-sync-upstream() {
        # sync upstream with origin without switching branch
        default_branch="$(git remote show upstream | sed -n '/HEAD branch/s/.*: //p')"
        git fetch upstream "$default_branch"
        git update-ref "refs/heads/$default_branch" "upstream/$default_branch"
        git push origin "$default_branch"
    }
fi

# docker
if has docker; then
    alias dat='docker attach'
    alias db='docker build'
    alias dbr='docker run --rm -it $(docker build -q .)'
    alias dcon='docker container'
    alias dex='docker exec -it'
    alias di='docker inspect'
    alias dim='docker image'
    alias diml='docker image ls'
    alias dimp='docker image prune'
    alias dl='docker pull'
    alias dlg='docker logs -f'
    alias dps='docker ps -a'
    alias drm='docker rm'
    alias drmi='docker rmi'
    alias dr='docker run --rm -it'
    alias dst='docker start -ai'
    alias dstp='docker stop'
    alias dk='docker kill'
    alias dv='docker volume'
    alias dvl='docker volume ls'
    alias dvp='docker volume prune'
    alias dvrm='docker volume rm'
fi

# docker-compose
# Refer to: oh-my-zsh/docker-compose.plugin.zsh
function {
    if has docker && docker compose &>/dev/null; then
        # Docker Compose V2
        local _dc='docker compose'
    elif has docker-compose; then
        # Docker Compose V1
        local _dc='docker-compose'
    fi

    if [ "$_dc" ]; then
        alias dcb="$_dc build"
        alias dce="$_dc exec"
        alias dcps="$_dc ps"
        alias dcrst="$_dc restart"
        alias dcrm="$_dc rm"
        alias dcr="$_dc run --rm"
        alias dcstp="$_dc stop"
        alias dcup="$_dc up"
        alias dcupb="$_dc up --build"
        alias dcupd="$_dc up -d"
        alias dcupdb="$_dc up -d --build"
        alias dcdn="$_dc down"
        alias dcl="$_dc logs -f"
        alias dcpl="$_dc pull"
        alias dcsta="$_dc start"
        alias dck="$_dc kill"
    fi
}

# kubectl
if has kubectl; then
    alias kc='kubectl'
fi

# brew
if has brew; then
    # brewit is my own function
    alias bi='brewit --verbose'
    alias bu='brew uninstall'
    alias bl='brew link'
fi

# gdb
if has gdb; then
    alias peda='gdb -q -ex init-peda'
    alias pwndbg='gdb -q -ex init-pwndbg'
fi

# network
function {
    # lsof
    # raw hostname(-n), raw port number(-P), inet4(-i4)
    if has lsof; then
        alias lsof-listen='lsof -nP -sTCP:LISTEN -i4TCP'
        alias lsof-connect='lsof -nP -i4TCP'
        lsof-port() {
            lsof -nP -i4TCP:$1
        }
    fi

    if has dig; then
        alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
        alias myip1='dig +short txt ch whoami.cloudflare @1.0.0.1'
    fi

    if has nettop; then
        # macOS; show delta(-d), per-process(-P)
        alias nettop='nettop -Pd'
    fi

    # packet filter
    if has pfctl; then
        alias pf-enable='sudo pfctl -ef /etc/pf.conf'
        alias pf-disable='sudo pfctl -d'
        alias pf-reload='sudo pfctl -F all -f /etc/pf.conf'
        alias pf-state='sudo pfctl -s state'
        alias pf-dryrun='pfctl -vnf /etc/pf.conf'
    fi

    if has ss; then
        alias sst='ss -lnpt4'
        alias ssu='ss -lnpu4'
    elif has netstat; then
        alias sst='netstat -lnpt4'
        alias ssu='netstat -lnpu4'
    fi

    if has ufw; then
        alias ufwl='sudo ufw status verbose'
    fi

    if has nft; then
        alias nftl='sudo nft --handle list ruleset'
    fi
}

# Poetry
if has poetry; then
    alias pt='poetry'
    alias pta='poetry add'
    alias ptad='poetry add -D'
    alias ptd='poetry remove'
    alias ptdd='poetry remove -D'
    alias pti='poetry install'
    alias ptl='poetry show'
    alias ptu='poetry env use'
fi

# systemd
# Refer to: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/systemd/systemd.plugin.zsh
if has systemctl; then
    alias sce='sudo systemctl enable'
    alias scen='sudo systemctl enable --now'
    alias scd='sudo systemctl disable'
    alias scdn='sudo systemctl disable --now'
    alias scst='sudo systemctl start'
    alias scstp='sudo systemctl stop'
    alias scr='sudo systemctl restart'
    alias scs='systemctl status'
fi
if has journalctl; then
    alias jc='journalctl -xeu'
fi

# radare2
if has radare2 && ! has r2; then
    alias r2='radare2'
fi

# rsync
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/rsync/rsync.plugin.zsh
if has rsync; then
    alias rsync-copy="rsync -avzPh"
    alias rsync-move="rsync -avzPh --remove-source-files"
    alias rsync-update="rsync -avzuPh"
    alias rsync-synchronize="rsync -avzu --delete -Ph"
fi


## oh-my-zsh/directories.zsh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh
# Changing/making/removing directory
setopt auto_cd # if !executable(cmd) and isdir(cmd) -> cd cmd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ..2='../..'
alias -g ..3='../../..'
alias -g ..4='../../../..'
alias -g ..5='../../../../..'

alias -- -='cd -'
alias -- -1='cd -'
alias -- -2='cd -2'
alias -- -3='cd -3'
alias -- -4='cd -4'
alias -- -5='cd -5'
alias -- -6='cd -6'
alias -- -7='cd -7'
alias -- -8='cd -8'
alias -- -9='cd -9'

# function d () {
#   if [[ -n $1 ]]; then
#     dirs "$@"
#   else
#     dirs -v | head -10
#   fi
# }
# compdef _dirs d
## end oh-my-zsh/directories.zsh


## oh-my-zsh/common-aliases.zsh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
# Advanced Aliases.
# Use with caution
#

# ls, the common ones I use a lot shortened for rapid fire usage
if has exa; then
    # exa is a modern ls replacement
    alias ls='exa -bg'        # binary size prefix, group
    alias l='ls -laa'         # long list, show all
    alias ll='ls -l'          # long list, ignore hidden files
    alias lt='ls -laar -snew' # sorted by modified date, newest first
    alias lr='ls -R'          # recursive
else
    if is_macos; then
        # colered, human readable
        # BSD-like systems have different arguments
        alias ls='ls -hG'
    else
        # colered, human readable
        alias ls='ls -h --color=auto'
    fi

    alias l='ls -la'       # long list, show all
    alias ll='ls -l'       # long list, ignore hidden files
    alias lt='ls -lat'     # sorted by date
    alias lr='ls -R'       # recursive
fi
# alias l='ls -lFh'     #size,show type,human readable
# alias la='ls -lAFh'   #long list,show almost all,show type,human readable
# alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
# alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
# alias ll='ls -l'      #long list
# alias ldot='ls -ld .*'
# alias lS='ls -1FSsh'
# alias lart='ls -1Fcart'
# alias lrt='ls -1Fcrt'

alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc' # Quick access to the .zshrc file

alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='2>&1 | head'
alias -g T='2>&1 | tail'
alias -g G='| grep'
alias -g L="2>&1 | less"
alias -g M="2>&1 | most"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"
alias -g X='| xargs'
if has ag; then
    alias -g G='| ag'
fi

# show files/directories by size
# duf seems faster
alias dud='du -d 1 -h | sort -hr'
alias duf='du -sh * | sort -hr'

# show all files/directories recursively
# see also `tree` function in OMZ/systemadmin
alias fdd='find . -type d'
alias fdf='find . -type f'
has fd && alias fd='fd -IHg'
has fdfind && alias fd='fdfind -IHg'

alias h='history'
alias hgrep="fc -El 0 | grep"

alias ps='ps -ef'
alias psenv='ps -efEww'

alias sortnr='sort -n -r'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts \
    'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
## end oh-my-zsh/common-aliases.zsh


## Convinient commands

size-tree() {
    du "$@" | tail -r | awk '{print $0 ":" $1}' | sed 's;[^/]*/;|____;g;s;____|; |;g'
}

# process status
#
# -f (full format): uid, pid, parent pid, recent CPU usage, process start time, controlling tty, elapsed CPU usage, command
# -j : user, pid, ppid, pgid, sess, jobc, state, tt, time, command
# -l : uid, pid, ppid, flags, cpu, pri, nice, vsz=SZ, rss, wchan, state=S, paddr=ADDR, tty, time, command=CMD
# -v : pid, state, time, sl, re, pagein, vsz, rss, lim, tsiz, %cpu, %mem, and command
# u (user-oriented): user, pid, %cpu, %mem, vsz, rss, tt, state, start, time, and command
# a : all users
# x : include tty-less
# -A / -e : all
# -a : all except tty-less
# -m : sorted by memory
# -r : sorted by CPU
# -E : show environment
# -w / -ww : wider output
#
# Arguments
#   $1 : pattern to find
#   $2 : columns that are changed for display, separated by commas. e.g. +etime,-ppid
#   $3.. : options for ps
p() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: $0 pattern +column1,-column2,..."
        return 1
    fi

    pattern=$1
    change_cols=(${(s:,:)2})

    defaults=(user pid ppid stime etime cmd)

    add=()
    del=()
    for col in $change_cols; do
        action=${col:0:1}
        name=${col:1}
        [ $action = + ] && add+=$name
        [ $action = - ] && del+=$name
    done

    columns=()
    for col in $defaults; do
        [ ! $del[(r)$col] ] && columns+=$col
    done
    columns+=($add)

    result=$(command ps -eo ${(j:,:)columns} $@[3,$])
    echo $result | head -n 1
    echo $result | grep --ignore-case --text --color=always $pattern
}

# Show colorbar to test terminal color
colorbar() {
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
                printf "\033[48;2;%d;%d;%dm", r,g,b;
                printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
                printf "%s\033[0m", substr(s,colnum+1,1);
            }
        printf "\n";
    }'
}

fonttest() {
    echo -e '\e[1mbold\e[22m'
    echo -e '\e[2mdim\e[22m'
    echo -e '\e[3mitalic\e[23m'
    echo -e '\e[4munderline\e[24m'
    echo -e '\e[4:1mthis is also underline (new in 0.52)\e[4:0m'
    echo -e '\e[21mdouble underline (new in 0.52)\e[24m'
    echo -e '\e[4:2mthis is also double underline (new in 0.52)\e[4:0m'
    echo -e '\e[4:3mcurly underline (new in 0.52)\e[4:0m'
    echo -e '\e[5mblink (new in 0.52)\e[25m'
    echo -e '\e[7mreverse\e[27m'
    echo -e '\e[8minvisible\e[28m <- invisible (but copy-pasteable)'
    echo -e '\e[9mstrikethrough\e[29m'
    echo -e '\e[53moverline (new in 0.52)\e[55m'

    echo -e '\e[31mred\e[39m'
    echo -e '\e[91mbright red\e[39m'
    echo -e '\e[38:5:42m256-color, de jure standard (ITU-T T.416)\e[39m'
    echo -e '\e[38;5;42m256-color, de facto standard (commonly used)\e[39m'
    echo -e '\e[38:2::240:143:104mtruecolor, de jure standard (ITU-T T.416) (new in 0.52)\e[39m'
    echo -e '\e[38:2:240:143:104mtruecolor, rarely used incorrect format (might be removed at some point)\e[39m'
    echo -e '\e[38;2;240;143;104mtruecolor, de facto standard (commonly used)\e[39m'

    echo -e '\e[46mcyan background\e[49m'
    echo -e '\e[106mbright cyan background\e[49m'
    echo -e '\e[48:5:42m256-color background, de jure standard (ITU-T T.416)\e[49m'
    echo -e '\e[48;5;42m256-color background, de facto standard (commonly used)\e[49m'
    echo -e '\e[48:2::240:143:104mtruecolor background, de jure standard (ITU-T T.416) (new in 0.52)\e[49m'
    echo -e '\e[48:2:240:143:104mtruecolor background, rarely used incorrect format (might be removed at some point)\e[49m'
    echo -e '\e[48;2;240;143;104mtruecolor background, de facto standard (commonly used)\e[49m'

    echo -e '\e[21m\e[58:5:42m256-color underline (new in 0.52)\e[59m\e[24m'
    echo -e '\e[21m\e[58;5;42m256-color underline (new in 0.52)\e[59m\e[24m'
    echo -e '\e[4:3m\e[58:2::240:143:104mtruecolor underline (new in 0.52) (*)\e[59m\e[4:0m'
    echo -e '\e[4:3m\e[58:2:240:143:104mtruecolor underline (new in 0.52) (might be removed at some point) (*)\e[59m\e[4:0m'
    echo -e '\e[4:3m\e[58;2;240;143;104mtruecolor underline (new in 0.52) (*)\e[59m\e[4:0m'
}

# Usage: program < input.txt | overwrite input.txt
overwrite() {
    n=$(tee >(cat 1<> "$1") | wc -c)
    truncate -s "$n" "$1"
}

urlencode() {
    # https://blog.longwin.com.tw/2017/12/bash-shell-curl-send-urlencode-args-2017/
    quoted=$(curl --silent --write-out '%{url_effective}' \
                  --get --data-urlencode "$1" '')
    ret=$?
    if [[ $ret != 3 ]]; then
        echo "Unexpected error" >&2
        return 1
    fi
    echo "${quoted##/?}"
}

urldecode() {
    unquoted="${1//+/ }"
    printf '%b' "${unquoted//%/\\x}"
}


shell-speed-test() {
    for i in $(seq 1 10); do time $SHELL -i -c exit; done
}

if ! has yq && has docker; then
    yq() {
        docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
    }
fi
