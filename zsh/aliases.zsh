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

has batcat && alias bat='batcat'
alias less='less -Ri' # -R: reads color codes; -i: ignore case
alias ln='ln -s' # --symbolic
alias wget='wget -c' # --continue; (--timestamping)
alias hd='hexdump -C' # hex+ascii

alias py='python3'
alias cl='clang'
alias cll='clang++'

# binutils
if is_macos; then
    alias objdump='objdump -x86-asm-syntax=intel'
    alias gobjdump='gobjdump -M intel'
else
    alias objdump='objdump -M intel'
fi

# vim
if has nvim; then
    alias vi='nvim'
    alias vim='nvim'
    alias vimdiff='nvim -d'
fi

# git
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
if has git; then
    # together with ohmyzsh git plugin
    alias gcll='git clone --recurse-submodules --depth 1'
fi

# docker
if has docker; then
    alias dat='docker attach'
    alias db='docker build'
    alias dbr='docker run --rm -it $(docker build -q .)'
    alias dcon='docker container'
    alias dex='docker exec -it'
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
        alias dcl="$_dc logs"
        alias dclf="$_dc logs -f"
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

# lsof
# raw hostname(-n), raw port number(-P), inet4(-i4)
# port is placeholder
if has lsof; then
    alias lsof-listen='lsof -nP -sTCP:LISTEN -i4TCP'
    alias lsof-connect='lsof -nP -i4TCP'
    lsof-port() {
        lsof -nP -i4TCP:$1
    }
fi

# packet filter
if has pfctl; then
    alias pf-enable='sudo pfctl -ef /etc/pf.conf'
    alias pf-disable='sudo pfctl -d'
    alias pf-reload='sudo pfctl -F all -f /etc/pf.conf'
    alias pf-state='sudo pfctl -s state'
    alias pf-dryrun='pfctl -vnf /etc/pf.conf'
fi

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
has fdfind && alias fd='fdfind'

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
p() {
    if has ag; then
        _grep=ag
    else
        _grep=grep
    fi

    # $1 : pattern
    # $2.. : options for ps
    # rss : resident set size = physical memory usage
    # first line is duplicated to stderr, useful when piping result to grep
    if [[ "$1" ]]; then
        ps -eo user,pid,ppid,lwp,state,start,time,etime,command $@[2,$] \
            | tee >(sed -n '1p' >&2) | "$_grep" -i "$1"
    else
        ps -eo user,pid,ppid,lwp,state,start,time,etime,command
    fi
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
