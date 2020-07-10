# Usage:
#     zinit ice <modifiers...>
#     zinit light/load/snippet ...
# light: no tracking
# load: with tracking, can be view by `zinit report`
# snippet: no execution for OMZ-specific code
#          (sometimes unnecessary as can be auto-detected)
#
# ice modifiers:
# wait: delayed loading
# lucid: no "Loaded ..." message when delayed loading is used
# light-mode: as light



# fish-like features
zinit wait lucid for \
  atload"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' atload"zicompinit; zicdreplay" \
      zinit zsh-users/zsh-completions
# CTRL-r for searching history
# zinit light zdharma/history-search-multi-word



## Oh My Zsh libraries and plugins
setopt promptsubst
# available libraries:
# bzr.zsh
# cli.zsh
# clipboard.zsh
# compfix.zsh
# completion.zsh
# correction.zsh
# diagnostics.zsh
# directories.zsh
# functions.zsh
# git.zsh
# grep.zsh
# history.zsh
# key-bindings.zsh
# misc.zsh
# nvm.zsh
# prompt_info_functions.zsh
# spectrum.zsh
# termsupport.zsh
# theme-and-appearance.zsh
zinit wait lucid for \
    OMZL::completion.zsh \
    OMZL::git.zsh \
    \
    OMZP::colored-man-pages \
    OMZP::command-not-found \
    OMZP::docker-compose \
    OMZP::encode64 \
    OMZP::pipenv \
    OMZP::systemadmin \
    OMZP::systemd \
    OMZP::thefuck \
    OMZP::urltools \
    OMZP::zsh_reload \
    \
    atload"unalias grv" \
        OMZP::git
#
# completions
zinit wait lucid as"completion" for \
    OMZP::fd/_fd \
    OMZP::docker/_docker \
    OMZP::docker-compose/_docker-compose \
    OMZP::pip/_pip \
    OMZP::ripgrep/_ripgrep \
    OMZP::gem/_gem
#
# following must not be delayed loading
# if so, history.zsh will cause history of previous sessions unloaded
# and key-binding will fail
# key-bindings: ^N and ^P is originally bind to {up,down}-line-or-history
zinit light-mode for \
    OMZL::history.zsh \
    atload'bindkey "^P" history-search-backward; \
           bindkey "^N" history-search-forward' \
        OMZL::key-bindings.zsh



## Theme
#
# Load the pure theme, with zsh-async library that's bundled with it.
# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure
#
# OMZ Theme
# zinit wait'!' lucid for \
#     OMZL::prompt_info_functions.zsh \
#     OMZT::gnzh
#
# Powerlevel10k
zinit atload'!source ~/.p10k.zsh' lucid for \
    romkatv/powerlevel10k



# fzf (fuzzy searcher) and its intergration with fasd (recent dir jumper)
# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
# as'program' will update $PATH
# key bindings:
# ^R : histoRy
# ^T : files under directory Tree
# ^G : Goto recent dir
zinit wait lucid for \
    from"gh-r" as"program" \
        junegunn/fzf-bin \
    atload'source shell/{key-bindings,completion}.zsh' \
        junegunn/fzf \
    as'program' atload'eval "$(fasd --init auto)"; zle -N _z; bindkey "^G" _z' \
        clvv/fasd

# TODO: ^G key binding not working, and causes problem when target dir is a
# python virtualenv
_z() {
    # from: https://github.com/junegunn/fzf/wiki/Examples#z
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}



# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is actually not needed, Zinit will
# grep operating system name and architecture automatically when there's no `bpick'.
# zinit ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"
# zinit load docker/compose

# Vim repository on GitHub – a typical source code that needs compilation – Zinit
# can manage it for you if you like, run `./configure` and other `make`, etc. stuff.
# Ice-mod `pick` selects a binary program to add to $PATH. You could also install the
# package under the path $ZPFX, see: http://zdharma.org/zinit/wiki/Compiling-programs
# zinit ice as"program" atclone"rm -f src/auto/config.cache; ./configure" \
#     atpull"%atclone" make pick"src/vim"
# zinit light vim/vim

# Scripts that are built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make'' ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only, default target.
# zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
# zinit light tj/git-extras

# Handle completions without loading any plugin, see "clist" command.
# This one is to be ran just once, in interactive session.
# zinit creinstall %HOME/my_completions

# For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the
# coreutils package from Homebrew; you can also use https://github.com/ogham/exa)
zinit ice wait lucid \
    atclone"(dircolors -b LS_COLORS || gdircolors -b LS_COLORS) > c.zsh" \
    atpull'%atclone' pick"c.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit load trapd00r/LS_COLORS

# zinit plugin manpages
zinit wait lucid for zinit-zsh/z-a-man


# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit wait lucid for \
#     zinit-zsh/z-a-as-monitor \
#     zinit-zsh/z-a-patch-dl \
#     zinit-zsh/z-a-bin-gem-node




##########
# Prezto #
##########






return

# antibody use oh-my-zsh

# theme
# antibody bundle romkatv/powerlevel10k powerlevel10k

# fish-like features
# antibody bundle zsh-users/zsh-autosuggestions
# antibody bundle zsh-users/zsh-completions
# antibody bundle zsh-users/zsh-history-substring-search
# antibody bundle zsh-users/zsh-syntax-highlighting

# completions
antibody bundle django
antibody bundle docker
antibody bundle fd
antibody bundle heroku
antibody bundle httpie # coloured curl
antibody bundle pip
antibody bundle ripgrep # alternative to grep / ag / ack
antibody bundle rvm

# aliases
antibody bundle brew # bubu = brew update|outdated|upgrade|cleanup
antibody bundle docker-compose # dcb, dcup
antibody bundle firewalld # fw / fwr / fwp / fwrp / fwl
antibody bundle nmap # nmap_open_ports ...
# antibody bundle git # ga, gc, gcl, gl, gp, ...
antibody bundle pipenv # pi = pipenv install
antibody bundle pylint # pylint-quick
antibody bundle rsync # rsync-copy / rsync-move / rsync-update / rsync-synchronize
antibody bundle systemd # sc-xxxx

# functions
antibody bundle cp # cpv = rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress
antibody bundle encode64 # e64 / d64
# antibody bundle extract # extract or x
# antibody bundle colorize # ccat
# antibody bundle jsontools # pp_json / is_json / urlencode_json / urldecode_json
antibody bundle systemadmin # ping / mkdir / clr / path / pscpu / psmem...
# antibody bundle vscode
antibody bundle urltools # urlencode / urldecode
# antibody bundle osx
# antibody bundle xcode # xcb

# plugins
# antibody bundle autoenv
# antibody bundle colored-man-pages
# antibody bundle fasd # fuzzy searcher
# antibody bundle fzf # fuzzy searcher
antibody bundle globalias # expand alias to original commands
antibody bundle pyenv # auto setup environment for pyenv
# antibody bundle transfer # transfer.sh
antibody bundle zsh_reload # src
# antibody bundle z # easy jump

# antibody bundle marlonrichert/zsh-autocomplete
antibody bundle andrewferrier/fzf-z

# disabled due to heavy start-up impact
# command-not-found
# thefuck
