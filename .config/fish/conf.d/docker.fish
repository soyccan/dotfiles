# inspired by ohmyzsh:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/docker/docker.plugin.zsh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/docker-compose/docker-compose.plugin.zsh

if not status is-interactive || not command -q docker
    exit
end

abbr da 'docker attach'
abbr db 'docker build'
abbr dbr 'docker run --rm (docker build --quiet .)'
abbr de 'docker exec'
abbr de! 'docker exec --interactive --tty'
abbr di 'docker inspect'
abbr dim 'docker image'
abbr diml 'docker image ls'
abbr dimt 'docker image tag'
abbr dk 'docker'
abbr dl 'docker logs --tail 100'
abbr dlf 'docker logs --tail 0 --follow'
abbr dn 'docker network'
abbr dnl 'docker network ls'
abbr dp 'docker push'
abbr dpl 'docker pull'
abbr dprt 'docker port'
abbr dps 'docker ps -a'
abbr dr 'docker run --rm'
abbr dr! 'docker run --rm --interactive --tty'
abbr drm 'docker rm'
abbr drmi 'docker image rm'
abbr drst 'docker restart'
abbr dst 'docker start'
abbr dst! 'docker start --attach --interactive'
abbr dstp 'docker stop'
abbr dtop 'docker top'
abbr dv 'docker volume'
abbr dvl 'docker volume ls'
abbr dvp 'docker volume prune'

begin # Docker Compose
    set -l dccmd
    if docker compose &>/dev/null
        # Docker Compose V2
        set dccmd 'docker compose'
    else if command -q docker-compose
        # Docker Compose V1
        set dccmd 'docker-compose'
    else
        exit
    end

    abbr dcb "$dccmd build"
    abbr dcdn "$dccmd down"
    abbr dce "$dccmd exec"
    abbr dck "$dccmd kill"
    abbr dcl "$dccmd logs --tail 100"
    abbr dclf "$dccmd logs --tail 0 --follow"
    abbr dco "$dccmd"
    abbr dcprt "$dccmd port"
    abbr dcps "$dccmd ps -a"
    abbr dcr "$dccmd run --rm"
    abbr dcrst "$dccmd restart"
    abbr dcrm "$dccmd rm"
    abbr dcst "$dccmd start"
    abbr dcstp "$dccmd stop"
    abbr dcup "$dccmd up --detach"
    abbr dcupb "$dccmd up --detach --build"
    abbr dcup! "$dccmd up"
    abbr dcupb! "$dccmd up --build"
end

