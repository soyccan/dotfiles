# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/globalias/globalias.plugin.zsh
#
# expand alias to full command

globalias() {
    # expand wildchar * ? to file list
    # zle expand-word

    zle _expand_alias
    zle self-insert
}

zle -N globalias

bindkey " " globalias
