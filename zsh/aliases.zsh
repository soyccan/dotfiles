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
alias gcll='git clone --recurse-submodules --depth 1' # together with 'git' plugin

alias py='python3'
alias cl='clang'
alias cll='clang++'

if [ "$(uname)" = 'Darwin' ]; then
    alias objdump='objdump -x86-asm-syntax=intel'
    alias gobjdump='gobjdump -M intel'
else
    alias objdump='objdump -M intel'
fi

if has nvim; then
    alias vi='nvim'
    alias vim='nvim'
    alias vimdiff='nvim -d'
fi

# docker
alias dat='docker attach'
alias db='docker build'
alias dcon='docker container'
alias dim='docker image'
alias diml='docker image ls'
alias dl='docker pull'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias drm='docker rm'
alias drmi='docker rmi'
alias drun='docker run -it'
alias dsta='docker start -ai'
alias dsto='docker stop'
alias dex='docker exec -it'

# gdb
alias peda='gdb -q -ex init-peda'
alias pwndbg='gdb -q -ex init-pwndbg'



# below are from common-aliases plugin of oh-my-zsh
# Advanced Aliases.
# Use with caution
#

# ls, the common ones I use a lot shortened for rapid fire usage
if [ "$(uname)" = 'Darwin' ]; then
    alias ls='ls -hG'   # colered, human readable
else
    alias ls='ls -h --color=auto' # colered, human readable
fi
alias l='ls -l'     # long list
alias ll='ls -la'   # long list, show all
alias lr='ls -R'    # recursive
alias lt='l -t'     # sorted by date
alias llt='ll -t'   # sorted by date
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


# expand alias to full command
# zinit snippet OMZ::plugins/globalias/globalias.plugin.zsh
globalias() {
    # expand wildchar * ? to file list
    # zle expand-word

    zle _expand_alias
    zle self-insert
}
zle -N globalias
bindkey " " globalias


if [ "$(uname)" = 'Darwin' ] && [ -e '/Applications/Turbo Boost Switcher.app' ]; then
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
