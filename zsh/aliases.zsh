# ${name:#pattern} tries to match $name with pattern
# refer to:
# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion
#
# (M) includes the matched portion in the result.
# refer to:
# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
ismacos=${(M)OSTYPE:#*darwin*}

# system commands
alias cp='cp -irv' # --interactive --recursive --verbose
alias mv='mv -iv' # --interactive --verbose
alias rm='rm -i' # --interactive=always

alias df='df -h' # --human-readable
alias du='du -h'  # --human-readable --apparent-size(-A) ; -A connot be used in macOS
alias free='free -h' # --human

alias ctar='tar -vcf' # create
alias ltar='tar -vtf' # list files
alias untar='tar -vxf' # extract
alias lzip='unzip -lv'
alias lrar='unrar l'

alias less='less -R' # --RAW-CONTROL-CHARS ; only color code is printed raw
alias ln='ln -s' # --symbolic
alias wget='wget -c' # --continue; (--timestamping)
alias hd='hexdump -C' # hex+ascii

alias py='python3'
alias python='python3'
alias cl='clang'
alias cll='clang++'

# binutils
if [ "$ismacos" ]; then
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
    alias dbd='docker build'
    alias dcon='docker container'
    alias dex='docker exec -it'
    alias dim='docker image'
    alias diml='docker image ls'
    alias dimp='docker image prune'
    alias dl='docker pull'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias drm='docker rm'
    alias drmi='docker rmi'
    alias drun='docker run -it'
    alias dsta='docker start -ai'
    alias dsto='docker stop'
    alias dv='docker volume'
    alias dvl='docker volume ls'
    alias dvp='docker volume prune'
    alias dvrm='docker volume rm'
fi

# docker-compose
# Refer to: oh-my-zsh/docker-compose.plugin.zsh
if has docker-compose; then
    alias dcb='docker-compose build'
    alias dce='docker-compose exec'
    alias dcps='docker-compose ps'
    alias dcrst='docker-compose restart'
    alias dcrm='docker-compose rm'
    alias dcr='docker-compose run'
    alias dcsto='docker-compose stop'
    alias dcup='docker-compose up'
    alias dcupd='docker-compose up -d'
    alias dcdn='docker-compose down'
    alias dcl='docker-compose logs'
    alias dclf='docker-compose logs -f'
    alias dcpl='docker-compose pull'
    alias dcsta='docker-compose start'
    alias dck='docker-compose kill'
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

# pipenv
# Refer to: oh-my-zsh/pipenv.plugin.zsh
# if has pipenv; then
#     alias pch='pipenv check'
#     alias pcl='pipenv clean'
#     alias pgr='pipenv graph'
#     alias pi='pipenv install --skip-lock --verbose'
#     alias pidev='pipenv install --skip-lock --verbose --dev'
#     alias pl='pipenv lock'
#     alias po='pipenv open'
#     alias ppy='pipenv --py'
#     alias prun='pipenv run'
#     alias psh='pipenv shell'
#     alias psy='pipenv sync'
#     alias pu='pipenv uninstall'
#     alias pvenv='pipenv --venv'
#     alias pwh='pipenv --where'
# fi

# systemd
# Refer to: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/systemd/systemd.plugin.zsh
if has systemctl; then
    alias sce='sudo systemctl enable'
    alias scen='sudo systemctl enable --now'
    alias scd='sudo systemctl disable'
    alias scdn='sudo systemctl disable --now'
    alias scst='sudo systemctl start'
    alias scsp='sudo systemctl stop'
    alias scr='sudo systemctl restart'
    alias scs='systemctl status'
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

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

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
    alias ls='exa -bg'  # binary size prefix, group
elif [ "$ismacos" ]; then
    # colered, human readable
    # BSD-like systems have different arguments
    alias ls='ls -hG'
else
    # colered, human readable
    alias ls='ls -h --color=auto'
fi
alias l='ls -laa'       # long list, show all
alias ll='ls -l'        # long list
alias lr='ls -R'        # recursive
alias lt='ls -laat'     # sorted by date
alias llt='ls -lt'      # sorted by date
# alias l='ls -lFh'     #size,show type,human readable
# alias la='ls -lAFh'   #long list,show almost all,show type,human readable
# alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
# alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
# alias ll='ls -l'      #long list
# alias ldot='ls -ld .*'
# alias lS='ls -1FSsh'
# alias lart='ls -1Fcart'
# alias lrt='ls -1Fcrt'

alias zshrc='${=EDITOR} ~/.zshrc' # Quick access to the ~/.zshrc file
alias ez='exec zsh' # a not-so-good way to reload config

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="2>&1 | less"
alias -g M="2>&1 | most"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"
alias -g X='| xargs'
alias -g XG='| xargs grep'
has ag && { alias -g G='| ag'; alias -g XG='| xargs ag'; }

# show files/directories by size
# duf seems faster
alias dud='du -d 1 -h | sort -hr'
alias duf='du -sh * | sort -hr'

# show all files/directories recursively
has fd || alias fd='find . -type d'
alias ff='find . -type f'

alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
p() {
    # -f : uid, pid, parent pid, recent CPU usage, process start time, controlling tty, elapsed CPU usage, command
    # -j : user, pid, ppid, pgid, sess, jobc, state, tt, time, command
    # -l : uid, pid, ppid, flags, cpu, pri, nice, vsz=SZ, rss, wchan, state=S, paddr=ADDR, tty, time, command=CMD
    # -v : pid, state, time, sl, re, pagein, vsz, rss, lim, tsiz, %cpu, %mem, and command
    # u (no hyphen) : user, pid, %cpu, %mem, vsz, rss, tt, state, start, time, and command
    # -e : all including no-terminal proccess
    # -a : all
    # -m : sorted by memory
    # -r : sorted by CPU
    # rss : resident set size = physical memory usage
    # first line is duplicated to stderr
    # it's convenient when piping result to grep
    ps -eo pid,user,state,etime,command | tee >(sed -n '1p' >&2)
}

alias sortnr='sort -n -r'
alias unexport='unset'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
## end oh-my-zsh/common-aliases.zsh


## oh-my-zsh/globalias.plugin.zsh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/globalias/globalias.plugin.zsh
# expand alias to full command
globalias() {
    # expand wildchar * ? to file list
    # zle expand-word

    zle _expand_alias
    zle self-insert
}
zle -N globalias
bindkey " " globalias
## end oh-my-zsh/globalias.plugin.zsh


if [ "$ismacos" ] && [ -e '/Applications/Turbo Boost Switcher.app' ]; then
    # disable Turbo Boost on macOS
    # required to install Turbo Boost Switcher
    # or clone from:
    # https://github.com/nanoant/DisableTurboBoost.kext
    # https://github.com/rugarciap/Turbo-Boost-Switcher
    turbooff() {
        sudo kextunload -b com.rugarciap.DisableTurboBoost
        sudo kextload '/Applications/Turbo Boost Switcher.app/Contents/Resources/DisableTurboBoost.64bits.kext'
    }
    turboon() {
        sudo kextunload -b com.rugarciap.DisableTurboBoost
    }
fi
