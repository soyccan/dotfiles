# inspired by ohmyzsh:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/docker/docker.plugin.zsh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/docker-compose/docker-compose.plugin.zsh

if not status is-interactive
    exit
end

begin
    set -l docker
    if command -q podman
        set docker podman
    else if command -q docker
        set docker docker
    else
        exit
    end

    abbr da "$docker attach"
    abbr db "$docker build --progress plain ."
    abbr dbr "$docker run --rm --interactive --tty ($docker build --quiet .)"
    abbr de "$docker exec"
    abbr de! "$docker exec --interactive --tty"
    abbr di "$docker inspect"
    abbr dim "$docker image"
    abbr diml "$docker image ls"
    abbr dimt "$docker image tag"
    abbr dk $docker
    abbr dl "$docker logs --tail 100"
    abbr dlf "$docker logs --tail 100 --follow"
    abbr dn "$docker network"
    abbr dnl "$docker network ls"
    abbr dp "$docker pull"
    abbr dP "$docker push"
    abbr dprt "$docker port"
    abbr dps "$docker ps --all"
    abbr dr "$docker run --rm"
    abbr dr! "$docker run --rm --interactive --tty"
    abbr drm "$docker rm"
    abbr drmi "$docker image rm"
    abbr drst "$docker restart"
    abbr drst! "$docker restart --attach --interactive"
    abbr dx "$docker stop"
    abbr dtop "$docker top"
    abbr dv "$docker volume"
    abbr dvl "$docker volume ls"
    abbr dvp "$docker volume prune"

    # Get container IP address
    alias dip "$docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

    set -l dc
    if command -q podman && podman compose &>/dev/null
        set dc 'podman compose'
    else if command -q docker && docker compose &>/dev/null
        # Docker Compose V2
        set dc 'docker compose'
    else if command -q docker-compose
        # Docker Compose V1
        set dc docker-compose
    else
        exit
    end

    abbr dcb "$dc build"
    abbr dcdn "$dc down"
    abbr dcdn! "$dc down --volumes"
    abbr dce "$dc exec"
    abbr dce! "$dc exec --interactive --tty"
    abbr dck "$dc kill"
    abbr dcl "$dc logs --tail 100"
    abbr dclf "$dc logs --tail 100 --follow"
    abbr dc "$dc"
    abbr dcp "$dc pull"
    abbr dcprt "$dc port"
    abbr dcps "$dc ps"
    abbr dcr "$dc run --rm"
    abbr dcr! "$dc run --rm --interactive --tty"
    abbr dcrst "$dc restart"
    abbr dcrm "$dc rm"
    abbr dcx "$dc stop"
    abbr dcup "$dc up --detach"
    abbr dcup! "$dc up --detach --force-recreate --remove-orphans --build"
end
