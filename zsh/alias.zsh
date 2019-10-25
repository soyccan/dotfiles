_docker_alias() {
    alias dat='docker attach'
    alias dcon='docker container'
    alias dim='docker image'
    alias dps='docker ps'
    alias dsta='docker start'
    alias dsto='docker stop'
    alias dex='docker exec'
}

if [ "$(uname)" = 'Linux' ]; then
    alias cp="cp --interactive --recursive --verbose"
    alias df="df --human-readable"
    alias du="du --human-readable --apparent-size"
    alias free="free --human"
    alias gcc="gcc -Wall -Wextra -std=c11 -lm -g -Dsoyccan"
    alias g++="g++ -Wall -Wextra -std=c++17 -g -Dsoyccan"
    alias less="less --RAW-CONTROL-CHARS" # color only
    alias ln="ln --symbolic"
    alias ls="ls --human-readable --color=auto"
    alias mv="mv --interactive"
    alias rm="rm --interactive=always"
    alias tar="tar --verbose"
    alias wget="wget --timestamping --continue"
    alias objdump="objdump -M intel -d"
    alias uex='rm -rf ~/.idm/uex/ ~/.idm/*.spl /tmp/*.spl ; /usr/bin/uex'
    alias hd='hexdump -C'

    _docker_alias

elif [ "$(uname)" = 'FreeBSD' ] || [ "$(uname)" = 'Darwin' ]; then
    alias cp="cp -irv"
    alias df="df -h"
    alias du="du -h" # -A connot be used in macOS
    alias free="free -h"
    alias gcc="gcc -Wall -Wextra -std=c11 -g -Dsoyccan"
    alias g++="g++ -Wall -Wextra -std=c++17 -g -Dsoyccan"
    alias less="less -R" # color only
    alias ln="ln -s"
    alias ls="ls -hG"
    alias mv="mv -i"
    alias rm="rm -i"
    alias tar="tar -v"
    alias wget="wget --timestamping -c"
    alias objdump="objdump -disassemble -x86-asm-syntax=intel"
    alias uex='rm -rf ~/.idm/uex/ ~/.idm/*.spl /tmp/*.spl ; /usr/bin/uex'
    alias hd='hexdump -C'

    _docker_alias
fi
