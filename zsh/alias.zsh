# common aliases
alias cp='cp -irv' # --interactive --recursive --verbose
alias df='df -h' # --human-readable
alias du='du -h'  # --human-readable --apparent-size(-A) ; -A connot be used in macOS
alias free='free -h' # --human
alias less='less -R' # --RAW-CONTROL-CHARS ; color only
alias ln='ln -s' # --symbolic'
alias mv='mv -i' # --interactive
alias rm='rm -i' # --interactive=always
alias tar='tar -v' # --verbose'
alias wget='wget --timestamping -c' # --continue
alias hd='hexdump -C' # hex+ascii

alias gcc='gcc -Wall -Wextra -Wconversion -std=c18   -g -Dsoyccan'
alias g++='g++ -Wall -Wextra -Wconversion -std=c++17 -g -Dsoyccan'

if [ "$(uname)" = 'Darwin' ]; then
    alias objdump='objdump -x86-asm-syntax=intel'
else
    alias objdump='objdump -M intel'
fi

# docker
alias dat='docker attach'
alias dcon='docker container'
alias dim='docker image'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dsta='docker start -ai'
alias dsto='docker stop'
alias dex='docker exec -it'
