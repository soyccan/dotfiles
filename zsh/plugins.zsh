## Usage:
# Traditional syntax:
#   zinit ice <modifiers...>
#   zinit light/load/snippet ...
# light: no tracking
# load: with tracking, can be view by `zinit report`
# snippet: no execution for OMZ-specific code
#          (sometimes unnecessary as can be auto-detected)
#
# Modern for syntax:
#   zinit <modifiers> for \
#     <modifiers A> @<plugin A> \
#     <modifiers B> @<plugin B> ...
#
# Modifiers:
#   wait: delayed loading. wait"!" has prompt reset after plugin is loaded
#   lucid: no "Loaded ..." message when delayed loading is used
#   light-mode: same as "zinit light ..."
#   is-snippet: same as "zinit snippet ..."
#
# Prepend an @ before the plugin name in case it's parsed as a modifier
# But in the absence of the ambiguity, @ can be omitted


## Annexes
# Load a few important annexes (Zinit extension)
# currently annexes require the absence of "wait"

# z-a-bin-gem-node: Add the support of ice modifiers like sbin, fbin, etc.
# so that binaries installed by Zinit requires no entry in $PATH
zinit for @zinit-zsh/z-a-bin-gem-node

# z-a-man: A Zsh-Zinit extension that automatically generates man pages out of
# plugin README.md files
# command: `zman`
# zinit for @zinit-zsh/z-a-man

# z-a-test: Specify modifier 'test' to run 'make test'
# zinit for zinit-zsh/z-a-test

# zinit for zinit-zsh/z-a-submods
# zinit for zinit-zsh/z-a-patch-dl

# TUI
# zinit for zdharma/zui
# zinit for zdharma/zplugin-crasis


## Basic setup
# fish-like features
zinit wait lucid for \
  atinit"zicompinit; zicdreplay" \
      @zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      @zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      @zsh-users/zsh-completions
# CTRL-r for searching history
# zinit light zdharma/history-search-multi-word


## Oh My Zsh libraries and plugins
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
    @OMZL::completion.zsh \
    @OMZL::git.zsh \
    \
    @OMZP::colored-man-pages \
    @OMZP::command-not-found \
    @OMZP::encode64 \
    @OMZP::pipenv \
    @OMZP::systemadmin \
    @OMZP::systemd \
    @OMZP::urltools \
    \
    atload"unalias grv; alias gc='git commit -m'" \
        @OMZP::git

# following must not be delayed loading
# if so, history.zsh will cause history of previous sessions unloaded
zinit for \
    @OMZL::history.zsh \


## Theme
# Most themes use this option
setopt promptsubst
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
# wait'!' to reset prompt after loaded
zinit for \
    src"$HOME/.p10k.zsh" \
        @romkatv/powerlevel10k


## Additional Completions
#     OMZP::autopep8/_autopep8 \
#     OMZP::docker/_docker \
#     OMZP::docker-compose/_docker-compose \
#     OMZP::pip/_pip \
#     OMZP::ripgrep/_ripgrep \
#     OMZP::gem/_gem \
#     OMZP::bundler/_bundler


## Complex plugins
# fzf: fuzzy searcher
# z.lua: Goto recent dir with fuzzy search
# Aliases:
#   zb : jump up to project root
#   zb <prefix> : jump up to directory starting with <prefix>
# Key bindings:
#   ^R : histoRy
#   ^T : files under directory Tree
#   ^G : Goto recent dir
zinit wait lucid for \
    from"gh-r" sbin"fzf" \
        @junegunn/fzf-bin \
    multisrc'shell/completion.zsh shell/key-bindings.zsh' \
        @junegunn/fzf \
    atload'eval "$(lua z.lua --init zsh)"
           zlua-goto() { _zlua -I . }
           zle -N zlua-goto
           bindkey "^G" zlua-goto' \
        @skywind3000/z.lua


## Examples from README
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
# exa also uses LS_COLORS
# zinit wait"0c" lucid for \
#     reset \
#     atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
#             \${P}sed -i \
#             '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
#             \${P}dircolors -b LS_COLORS > c.zsh" \
#     atpull'%atclone' pick"c.zsh" nocompile'!' \
#     atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
#     trapd00r/LS_COLORS


## Binaries and Their Completions
# lazygit
zinit wait lucid for \
    from'gh-r' sbin'lazygit' \
        @jesseduffield/lazygit
# lua
if is_linux && ! has lua; then
    zinit wait lucid for \
        as'command' extract sbin'lua54 -> lua' \
        https://downloads.sourceforge.net/project/luabinaries/5.4.2/Tools%20Executables/lua-5.4.2_Linux54_64_bin.tar.gz

elif is_macos && ! has lua; then
    zinit wait lucid for \
        as'command' extract sbin'lua53 -> lua' \
        https://downloads.sourceforge.net/project/luabinaries/5.3.5/Tools%20Executables/lua-5.3.5_MacOS1013_bin.tar.gz
fi

# pastel: Color generater
# zinit wait lucid for \
#     from"gh-r" sbin"**/pastel" \
#         @sharkdp/pastel

# tmux: Terminal multiplexer
if is_linux && ! has tmux; then
    zinit wait lucid for \
        from"gh-r" bpick"tmux-3.1b-x86_64.AppImage" sbin"tmux* -> tmux" \
            @tmux/tmux
fi

# NeoVim: Modern editor based on VIM
if is_linux && ! has nvim; then
    zinit wait lucid for \
        from"gh-r" bpick"nvim-linux64.tar.gz" sbin"*/bin/nvim" \
            @neovim/neovim

elif is_macos && ! has nvim; then
    zinit wait lucid for \
        from"gh-r" bpick"nvim-macos.tar.gz" sbin"*/bin/nvim" \
            @neovim/neovim
fi

# shellcheck: Shell script linter
zinit wait lucid for \
    from"gh-r" sbin"**/shellcheck" \
        @koalaman/shellcheck

# ag: A fast alternative to grep
# No GitHub release exist
zinit wait lucid for \
    as"completion" \
        @ggreer/the_silver_searcher

# rg: A fast alternative to grep
# along with completion
zinit wait lucid for \
    from"gh-r" sbin"**/rg" \
        @BurntSushi/ripgrep \

# fd: A simple, fast and user-friendly alternative to 'find'
zinit wait lucid for \
    from"gh-r" sbin"**/fd" id-as"sharkdp/fd-bin" \
        @sharkdp/fd \
    as"completion" \
        @sharkdp/fd

# bat: A cat(1) clone with wings
zinit wait lucid for \
    from"gh-r" sbin"**/bat" \
        @sharkdp/bat

# exa: Replacement for ls
zinit wait lucid for \
    from"gh-r" sbin"**/exa -> exa" id-as"ogham/exa-bin" \
        @ogham/exa \
    as"completion" cp"completions/completions.zsh -> _exa" \
        @ogham/exa

# Docker and docker-compose
# Docker should be install by system
# and docker-compose is usually bundled with Docker
# so we do not install them here
zinit wait lucid for \
    as"completion" \
        @docker/compose \
        @docker/cli
#     from"gh-r" as"program" mv"docker* -> docker-compose" \
#     docker/compose

# nnn: A terminal file browser
# zinit pick"misc/quitcd/quitcd.zsh" sbin make for jarun/nnn

# Build VIM from source
# zinit wait lucid for \
#     as"program" atclone"rm -f src/auto/config.cache; ./configure" \
#     atpull"%atclone" make pick"src/vim" \
#     vim/vim

# direnv: Dir-specific env vars, set/unset as dir changes
# zinit wait lucid for \
#     make'!' atclone'./direnv hook zsh > zhook.zsh' \
#     atpull'%atclone' src"zhook.zsh" \
#     sbin"direnv* -> direnv" \
#     direnv/direnv

# shfmt: Format shell programs
# gosh: A proof-of-concept shell
zinit wait lucid for \
    from"gh-r" sbin"shfmt* -> shfmt" \
        @mvdan/sh

# gotcha: A simple tool that grabs Go packages
# zinit wait lucid for \
#     from"gh-r" as"program" mv"gotcha_* -> gotcha" \
#     b4b4r07/gotcha

# yank: Yank terminal output to clipboard
# Usage: some_commond | yank
# zinit wait lucid for \
#     sbin"yank" make \
#         @mptre/yank

# Vramstep: Progress bar
# zinit wait lucid for \
#     sbin'src/vramsteg' \
#     atclone'cmake .' atpull'%atclone' make \
#         @psprint/vramsteg-zsh

# pyenv: Simple Python version management
# zinit wait lucid for \
#     atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh' \
#     atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
#     sbin'bin/pyenv' src"zpyenv.zsh" nocompile'!' \
#         @pyenv/pyenv

# asciinema: Terminal session recorder
# zinit wait lucid for \
#     atinit"export PYTHONPATH=$ZPFX/lib/python3.7/site-packages/" \
#     atclone"PYTHONPATH=$ZPFX/lib/python3.7/site-packages/ \
#             python3 setup.py --quiet install --prefix $ZPFX" \
#     atpull'%atclone' \
#     sbin"$ZPFX/bin/asciinema" \
#         @asciinema/asciinema.git

# Whenever a manual build without Github repo is needed, zdharma/null serves as
# a placeholder

# SDKMAN! the Software Development Kit Manager
# zinit wait lucid for \
#     as"program" pick"$ZPFX/sdkman/bin/sdk" id-as'sdkman' run-atpull \
#     atclone"wget https://get.sdkman.io/?rcupdate=false -O scr.sh; SDKMAN_DIR=$ZPFX/sdkman bash scr.sh" \
#     atpull"SDKMAN_DIR=$ZPFX/sdkman sdk selfupdate" \
#     atinit"export SDKMAN_DIR=$ZPFX/sdkman; source $ZPFX/sdkman/bin/sdkman-init.sh" \
#     zdharma/null

# Installation of Rust compiler environment via the z-a-rust annex
# zinit wait"1" lucid for \
#     id-as"rust" as"null" sbin"bin/*" rustup \
#     atload="[[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall -q rust; \
#             export CARGO_HOME=\$PWD; export RUSTUP_HOME=\$PWD/rustup" \
#     zdharma/null



### Below are from gallery, and are being reviewed
# http://zdharma.org/zinit/wiki/GALLERY/
# ## Scripts
# # revolver
# zinit ice wait"2" lucid as"program" pick"revolver"
# zinit light molovo/revolver
#
# # zunit
# zinit ice wait"2" lucid as"program" pick"zunit" \
#             atclone"./build.zsh" atpull"%atclone"
# zinit load molovo/zunit
#
# zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX" nocompile
# zinit light tj/git-extras
#
# zinit ice as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' \
#     atpull'%atclone' make'install' pick"$ZPFX/bin/git-cal"
# zinit light k4rthik/git-cal
#
# zinit ice as"program" id-as"git-unique" pick"git-unique"
# zinit snippet https://github.com/Osse/git-scripts/blob/master/git-unique
#
# zinit ice as"program" cp"wd.sh -> wd" mv"_wd.sh -> _wd" \
#     atpull'!git reset --hard' pick"wd"
# zinit light mfaerevaag/wd
#
# zinit ice as"program" pick"bin/archey"
# zinit load obihann/archey-osx
#
# ## Plugins
# zinit ice pick"h.sh"
# zinit light paoloantinori/hhighlighter
#
# # zsh-tag-search; after ^G, prepend with "/" for the regular search
# zinit ice wait lucid bindmap"^R -> ^G"
# zinit light -b zdharma/zsh-tag-search
#
# # forgit
# zinit ice wait lucid
# zinit load 'wfxr/forgit'
#
# # diff-so-fancy
# zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
# zinit load zdharma/zsh-diff-so-fancy
#
# # zsh-startify, a vim-startify like plugin
# zinit ice wait"0b" lucid atload"zsh-startify"
# zinit load zdharma/zsh-startify
#
# # declare-zsh
# zinit ice wait"2" lucid
# zinit load zdharma/declare-zsh
#
# # fzf-marks
# zinit ice wait lucid
# zinit load urbainvaes/fzf-marks
#
# # zsh-autopair
# zinit ice wait lucid
# zinit load hlissner/zsh-autopair
#
# zinit ice wait"1" lucid
# zinit load psprint/zsh-navigation-tools
#
# # zdharma/history-search-multi-word
# zstyle ":history-search-multi-word" page-size "11"
# zinit ice wait"1" lucid
# zinit load zdharma/history-search-multi-word
#
# # ZUI and Crasis
# zinit ice wait"1" lucid
# zinit load zdharma/zui
#
# zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)cra*]} ]]' lucid
# zinit load zdharma/zinit-crasis
#
# # Gitignore plugin – commands gii and gi
# zinit ice wait"2" lucid
# zinit load voronkovich/gitignore.plugin.zsh
#
# # Autosuggestions & fast-syntax-highlighting
# zinit ice wait lucid atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
# zinit light zdharma/fast-syntax-highlighting
# # zsh-autosuggestions
# zinit ice wait lucid atload"!_zsh_autosuggest_start"
# zinit load zsh-users/zsh-autosuggestions
#
# # F-Sy-H automatic per-directory themes plugin – available for patrons:
# # https://patreon.com/psprint
# zinit ice wait"1" lucid from"psprint@gitlab.com"
# zinit load psprint/fsh-auto-themes
#
# # zredis together with some binding/tying
# # – defines the variable $rdhash
# zstyle ":plugin:zredis" configure_opts "--without-tcsetpgrp"
# zstyle ":plugin:zredis" cflags  "-Wall -O2 -g -Wno-unused-but-set-variable"
# zinit ice wait"1" lucid \
#     atload'ztie -d db/redis -a 127.0.0.1:4815/5 -zSL main rdhash'
# zinit load zdharma/zredis
#
# # Github-Issue-Tracker – the notifier thread
# zinit ice lucid id-as"GitHub-notify" \
#         on-update-of'~/.cache/zsh-github-issues/new_titles.log' \
#         notify'New issue: $NOTIFY_MESSAGE'
# zinit light zdharma/zsh-github-issues
#
# ## Services
# # a service that runs the redis database, in background, single instance
# zinit ice wait"1" lucid service"redis"
# zinit light zservices/redis
#
# # Github-Issue-Tracker – the issue-puller thread
# GIT_SLEEP_TIME=700
# GIT_PROJECTS=zdharma/zsh-github-issues:zdharma/zinit
#
# zinit ice wait"2" lucid service"GIT" pick"zsh-github-issues.service.zsh"
# zinit light zdharma/zsh-github-issues

### end gallery

