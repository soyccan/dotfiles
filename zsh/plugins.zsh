## Usage:
# Traditional syntax:
#   zi ice <modifiers...>
#   zi light/load/snippet ...
# light: no tracking
# load: with tracking, can be view by `zi report`
# snippet: no execution for OMZ-specific code
#          (sometimes unnecessary as can be auto-detected)
#
# Modern for syntax:
#   zi <modifiers> depth"1" for \
#     <modifiers A> @<plugin A> \
#     <modifiers B> @<plugin B> ...
#
# Modifiers:
#   wait: delayed loading. wait"!" has prompt reset after plugin is loaded
#   lucid: no "Loaded ..." message when delayed loading is used
#   light-mode: same as "zi light ..."
#   is-snippet: same as "zi snippet ..."
#
# Prepend an @ before the plugin name in case it's parsed as a modifier
# But in the absence of the ambiguity, @ can be omitted


## Annexes
# Load a few important annexes (zi extension)
# currently annexes require the absence of "wait"

# z-a-bin-gem-node: Add the support of ice modifiers like sbin, fbin, etc.
# so that binaries installed by zi requires no entry in $PATH
zi depth"1" for @z-shell/z-a-bin-gem-node

# z-a-man: A Zsh-zi extension that automatically generates man pages out of
# plugin README.md files
# command: `zman`
# zi for @zi-zsh/z-a-man

# z-a-test: Specify modifier 'test' to run 'make test'
# zi for zi-zsh/z-a-test

# zi for zi-zsh/z-a-submods

# A ZI Annex (extension) that downloads files and applies patches.
zi depth"1" for @z-shell/z-a-patch-dl

# TUI
# zi for zdharma/zui
# zi for zdharma/zplugin-crasis


## Basic setup
# fish-like features
# https://z-shell.pages.dev/docs/gallery/collection#minimal
# F-Sy-H: fast-syntax-highlighting
zi wait lucid depth"1" for \
  atinit"zicompinit; zicdreplay" \
    @z-shell/F-Sy-H \
  atload"_zsh_autosuggest_start" \
    @zsh-users/zsh-autosuggestions \
  blockf atpull'zi creinstall -q .' \
    @zsh-users/zsh-completions
# CTRL-r for searching history
# zi light zdharma/history-search-multi-word


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
zi wait lucid depth"1" for \
    @OMZL::completion.zsh \
    @OMZL::git.zsh \
    \
    @OMZP::colored-man-pages \
    @OMZP::command-not-found \
    @OMZP::encode64 \
    @OMZP::systemadmin \
    @OMZP::systemd \
    @OMZP::urltools \
    \
    atload"unalias grv; alias gc='git commit -m'" \
        @OMZP::git

# following must not be delayed loading
# if so, history.zsh will cause history of previous sessions unloaded
zi depth"1" for \
    @OMZL::history.zsh \


## Theme
# Most themes use this option
setopt promptsubst
# Load the pure theme, with zsh-async library that's bundled with it.
# zi ice pick"async.zsh" src"pure.zsh"
# zi light sindresorhus/pure
#
# OMZ Theme
# zi wait'!' lucid depth"1" for \
#     OMZL::prompt_info_functions.zsh \
#     OMZT::gnzh
#
# Powerlevel10k
# wait'!' to reset prompt after loaded
zi depth"1" for \
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
#
# fzf: fuzzy searcher. https://github.com/z-shell/fzf
# fasd: access recently used files/dirs. https://github.com/clvv/fasd
#
# Default key bindings by fzf:
#   ^R : paste selected command histo(r)y into command line
#   ^T : paste selected file under current dir (t)ree into command line
#   ALT-C / <ESC>+c : (c)d into selected dir under current tree
#
# My key bindings:
#   ^G : 1. (g)oto recent dir
#        2. paste selected file from recently used files into command line
#
fzf-fasd-widget() {
  # Reference: https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
  setopt localoptions pipefail no_aliases 2> /dev/null
  if [[ -n "$LBUFFER" ]]; then
    # if user have typed something when pressing ^G,
    # select from recently used files and insert into command line

    local item
    local opts="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS"
    # -m : multiple select
    local files="$(fasd -Rlf | FZF_DEFAULT_OPTS="$opts" $(__fzfcmd) -m | while read item; do
      echo -n "${(q)item} "
    done)"
    local ret=$?

    if [[ -z "$files" ]]; then
      zle redisplay
      return 0
    fi

    LBUFFER="${LBUFFER}${files}"
    zle reset-prompt
    return $ret
  else
    # if cursor is at head when pressing ^G, select and goto recent dir

    local opts="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS"
    local dir="$(fasd -Rld | FZF_DEFAULT_OPTS="$opts" $(__fzfcmd) +m)"

    if [[ -z "$dir" ]]; then
      zle redisplay
      return 0
    fi

    zle push-line # Clear buffer. Auto-restored on next prompt.
    BUFFER="cd -- ${(q)dir}"
    zle accept-line
    local ret=$?
    unset dir # ensure this doesn't end up appearing in prompt expansion
    zle reset-prompt
    return $ret
  fi
}
fzf-file-widget-smarter() {
  setopt localoptions pipefail no_aliases 2> /dev/null

  if [[ "${LBUFFER[-1]}" = ' ' ]]; then
    # fallback to cwd
    local dir=./
  else
    # used last word in command line as target dir
    # (z) splits string into words
    # use eval to glob & expand pathname
    eval "local dir=${${(z)LBUFFER}[-1]}"
  fi

  local cmd="${FZF_CTRL_T_COMMAND:-"command find -L '$dir' \
    -mindepth 1 \
    '(' \
      -path '*/\\.*' \
      -o -fstype sysfs \
      -o -fstype devfs \
      -o -fstype devtmpfs \
      -o -fstype proc \
    ')' \
    -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null"}"

  local item
  local opts="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS"
  # -m : multiple select
  local files="$(eval "$cmd" | FZF_DEFAULT_OPTS="$opts" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item#${dir}} "
  done)"
  local ret=$?

  LBUFFER="${LBUFFER}${files}"
  zle reset-prompt
  return $ret
}
zle -N fzf-fasd-widget
zle -N fzf-file-widget-smarter
zi wait lucid depth"1" for \
    pack"bgn-binary+keys" \
        @fzf \
    sbin"fasd" \
    atload'eval "$(fasd --init auto)"
           bindkey "^T" fzf-file-widget-smarter
           bindkey "^G" fzf-fasd-widget' \
        @clvv/fasd
# zi wait lucid depth"1" for \
#     from"gh-r" sbin"fzf" \
#         @junegunn/fzf-bin \
#     multisrc'shell/completion.zsh shell/key-bindings.zsh' \
#         @junegunn/fzf \
#     atload'eval "$(lua z.lua --init zsh)"
#            zlua-goto() { _zlua -I . }
#            zle -N zlua-goto
#            bindkey "^G" zlua-goto' \
#         @skywind3000/z.lua


## Examples from README
# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is actually not needed, zi will
# grep operating system name and architecture automatically when there's no `bpick'.
# zi ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"
# zi load docker/compose

# Vim repository on GitHub – a typical source code that needs compilation – zi
# can manage it for you if you like, run `./configure` and other `make`, etc. stuff.
# Ice-mod `pick` selects a binary program to add to $PATH. You could also install the
# package under the path $ZPFX, see: http://zdharma.org/zi/wiki/Compiling-programs
# zi ice as"program" atclone"rm -f src/auto/config.cache; ./configure" \
#     atpull"%atclone" make pick"src/vim"
# zi light vim/vim

# Scripts that are built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make'' ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only, default target.
# zi ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
# zi light tj/git-extras

# Handle completions without loading any plugin, see "clist" command.
# This one is to be ran just once, in interactive session.
# zi creinstall %HOME/my_completions

# For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the
# coreutils package from Homebrew; you can also use https://github.com/ogham/exa)
# exa also uses LS_COLORS
# zi wait"0c" lucid depth"1" for \
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
#zi wait lucid depth"1" for \
#    from'gh-r' sbin'lazygit' \
#        @jesseduffield/lazygit
# lua
# if is_linux && ! has lua; then
#     zi wait lucid depth"1" for \
#         as'command' extract sbin'lua54 -> lua' \
#         https://downloads.sourceforge.net/project/luabinaries/5.4.2/Tools%20Executables/lua-5.4.2_Linux54_64_bin.tar.gz
#
# elif is_macos && ! has lua; then
#     zi wait lucid depth"1" for \
#         as'command' extract sbin'lua53 -> lua' \
#         https://downloads.sourceforge.net/project/luabinaries/5.3.5/Tools%20Executables/lua-5.3.5_MacOS1013_bin.tar.gz
# fi

# pastel: Color generater
# zi wait lucid depth"1" for \
#     from"gh-r" sbin"**/pastel" \
#         @sharkdp/pastel

# tmux: Terminal multiplexer
# if is_linux && ! has tmux; then
#     zi wait lucid depth"1" for \
#         from"gh-r" bpick"tmux-3.1b-x86_64.AppImage" sbin"tmux* -> tmux" \
#             @tmux/tmux
# fi

# NeoVim: Modern editor based on VIM
# if is_linux && ! has nvim; then
#     zi wait lucid depth"1" for \
#         from"gh-r" bpick"nvim-linux64.tar.gz" sbin"*/bin/nvim" \
#             @neovim/neovim
#
# elif is_macos && ! has nvim; then
#     zi wait lucid depth"1" for \
#         from"gh-r" bpick"nvim-macos.tar.gz" sbin"*/bin/nvim" \
#             @neovim/neovim
# fi

# shellcheck: Shell script linter
zi wait lucid depth"1" for \
    from"gh-r" sbin"**/shellcheck" \
        @koalaman/shellcheck

# ag: A fast alternative to grep
# No GitHub release exist
zi wait lucid depth"1" for \
    as"completion" \
        @ggreer/the_silver_searcher

# rg: A fast alternative to grep
# along with completion
zi wait lucid depth"1" for \
    from"gh-r" sbin"**/rg" \
        @BurntSushi/ripgrep \

# fd: A simple, fast and user-friendly alternative to 'find'
zi wait lucid depth"1" for \
    from"gh-r" sbin"**/fd" id-as"sharkdp/fd-bin" \
        @sharkdp/fd \
    as"completion" \
        @sharkdp/fd

# bat: A cat(1) clone with wings
zi wait lucid depth"1" for \
    from"gh-r" sbin"**/bat" \
        @sharkdp/bat

# exa: Replacement for ls
zi wait lucid depth"1" for \
    from"gh-r" sbin"**/exa -> exa" id-as"ogham/exa-bin" \
        @ogham/exa \
    as"completion" cp"completions/completions.zsh -> _exa" \
        @ogham/exa

# Docker and docker-compose
# Docker should be install by system
# and docker-compose is usually bundled with Docker
# so we do not install them here
# zi wait lucid depth"1" for \
#     as"completion" \
#         @docker/compose \
#         @docker/cli
#     from"gh-r" as"program" mv"docker* -> docker-compose" \
#     docker/compose

# nnn: A terminal file browser
# zi pick"misc/quitcd/quitcd.zsh" sbin make for jarun/nnn

# Build VIM from source
# zi wait lucid depth"1" for \
#     as"program" atclone"rm -f src/auto/config.cache; ./configure" \
#     atpull"%atclone" make pick"src/vim" \
#     vim/vim

# direnv: Dir-specific env vars, set/unset as dir changes
# zi wait lucid depth"1" for \
#     make'!' atclone'./direnv hook zsh > zhook.zsh' \
#     atpull'%atclone' src"zhook.zsh" \
#     sbin"direnv* -> direnv" \
#     direnv/direnv

# shfmt: Format shell programs
# gosh: A proof-of-concept shell
# zi wait lucid depth"1" for \
#     from"gh-r" sbin"shfmt* -> shfmt" \
#         @mvdan/sh

# gotcha: A simple tool that grabs Go packages
# zi wait lucid depth"1" for \
#     from"gh-r" as"program" mv"gotcha_* -> gotcha" \
#     b4b4r07/gotcha

# yank: Yank terminal output to clipboard
# Usage: some_commond | yank
# zi wait lucid depth"1" for \
#     sbin"yank" make \
#         @mptre/yank

# Vramstep: Progress bar
# zi wait lucid depth"1" for \
#     sbin'src/vramsteg' \
#     atclone'cmake .' atpull'%atclone' make \
#         @psprint/vramsteg-zsh

# pyenv: Simple Python version management
# zi wait lucid depth"1" for \
#     atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh' \
#     atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
#     sbin'bin/pyenv' src"zpyenv.zsh" nocompile'!' \
#         @pyenv/pyenv

# asciinema: Terminal session recorder
# zi wait lucid depth"1" for \
#     atinit"export PYTHONPATH=$ZPFX/lib/python3.7/site-packages/" \
#     atclone"PYTHONPATH=$ZPFX/lib/python3.7/site-packages/ \
#             python3 setup.py --quiet install --prefix $ZPFX" \
#     atpull'%atclone' \
#     sbin"$ZPFX/bin/asciinema" \
#         @asciinema/asciinema.git

# Whenever a manual build without Github repo is needed, zdharma/null serves as
# a placeholder

# SDKMAN! the Software Development Kit Manager
# zi wait lucid depth"1" for \
#     as"program" pick"$ZPFX/sdkman/bin/sdk" id-as'sdkman' run-atpull \
#     atclone"wget https://get.sdkman.io/?rcupdate=false -O scr.sh; SDKMAN_DIR=$ZPFX/sdkman bash scr.sh" \
#     atpull"SDKMAN_DIR=$ZPFX/sdkman sdk selfupdate" \
#     atinit"export SDKMAN_DIR=$ZPFX/sdkman; source $ZPFX/sdkman/bin/sdkman-init.sh" \
#     zdharma/null

# Installation of Rust compiler environment via the z-a-rust annex
# zi wait"1" lucid depth"1" for \
#     id-as"rust" as"null" sbin"bin/*" rustup \
#     atload="[[ ! -f ${zi[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall -q rust; \
#             export CARGO_HOME=\$PWD; export RUSTUP_HOME=\$PWD/rustup" \
#     zdharma/null



### Below are from gallery, and are being reviewed
# http://zdharma.org/zi/wiki/GALLERY/
# ## Scripts
# # revolver
# zi ice wait"2" lucid as"program" pick"revolver"
# zi light molovo/revolver
#
# # zunit
# zi ice wait"2" lucid as"program" pick"zunit" \
#             atclone"./build.zsh" atpull"%atclone"
# zi load molovo/zunit
#
# zi ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX" nocompile
# zi light tj/git-extras
#
# zi ice as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' \
#     atpull'%atclone' make'install' pick"$ZPFX/bin/git-cal"
# zi light k4rthik/git-cal
#
# zi ice as"program" id-as"git-unique" pick"git-unique"
# zi snippet https://github.com/Osse/git-scripts/blob/master/git-unique
#
# zi ice as"program" cp"wd.sh -> wd" mv"_wd.sh -> _wd" \
#     atpull'!git reset --hard' pick"wd"
# zi light mfaerevaag/wd
#
# zi ice as"program" pick"bin/archey"
# zi load obihann/archey-osx
#
# ## Plugins
# zi ice pick"h.sh"
# zi light paoloantinori/hhighlighter
#
# # zsh-tag-search; after ^G, prepend with "/" for the regular search
# zi ice wait lucid bindmap"^R -> ^G"
# zi light -b zdharma/zsh-tag-search
#
# # forgit
# zi ice wait lucid
# zi load 'wfxr/forgit'
#
# # diff-so-fancy
# zi ice wait"2" lucid as"program" pick"bin/git-dsf"
# zi load zdharma/zsh-diff-so-fancy
#
# # zsh-startify, a vim-startify like plugin
# zi ice wait"0b" lucid atload"zsh-startify"
# zi load zdharma/zsh-startify
#
# # declare-zsh
# zi ice wait"2" lucid
# zi load zdharma/declare-zsh
#
# # fzf-marks
# zi ice wait lucid
# zi load urbainvaes/fzf-marks
#
# # zsh-autopair
# zi ice wait lucid
# zi load hlissner/zsh-autopair
#
# zi ice wait"1" lucid
# zi load psprint/zsh-navigation-tools
#
# # zdharma/history-search-multi-word
# zstyle ":history-search-multi-word" page-size "11"
# zi ice wait"1" lucid
# zi load zdharma/history-search-multi-word
#
# # ZUI and Crasis
# zi ice wait"1" lucid
# zi load zdharma/zui
#
# zi ice wait'[[ -n ${ZLAST_COMMANDS[(r)cra*]} ]]' lucid
# zi load zdharma/zi-crasis
#
# # Gitignore plugin – commands gii and gi
# zi ice wait"2" lucid
# zi load voronkovich/gitignore.plugin.zsh
#
# # Autosuggestions & fast-syntax-highlighting
# zi ice wait lucid atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
# zi light zdharma/fast-syntax-highlighting
# # zsh-autosuggestions
# zi ice wait lucid atload"!_zsh_autosuggest_start"
# zi load zsh-users/zsh-autosuggestions
#
# # F-Sy-H automatic per-directory themes plugin – available for patrons:
# # https://patreon.com/psprint
# zi ice wait"1" lucid from"psprint@gitlab.com"
# zi load psprint/fsh-auto-themes
#
# # zredis together with some binding/tying
# # – defines the variable $rdhash
# zstyle ":plugin:zredis" configure_opts "--without-tcsetpgrp"
# zstyle ":plugin:zredis" cflags  "-Wall -O2 -g -Wno-unused-but-set-variable"
# zi ice wait"1" lucid \
#     atload'ztie -d db/redis -a 127.0.0.1:4815/5 -zSL main rdhash'
# zi load zdharma/zredis
#
# # Github-Issue-Tracker – the notifier thread
# zi ice lucid id-as"GitHub-notify" \
#         on-update-of'~/.cache/zsh-github-issues/new_titles.log' \
#         notify'New issue: $NOTIFY_MESSAGE'
# zi light zdharma/zsh-github-issues
#
# ## Services
# # a service that runs the redis database, in background, single instance
# zi ice wait"1" lucid service"redis"
# zi light zservices/redis
#
# # Github-Issue-Tracker – the issue-puller thread
# GIT_SLEEP_TIME=700
# GIT_PROJECTS=zdharma/zsh-github-issues:zdharma/zi
#
# zi ice wait"2" lucid service"GIT" pick"zsh-github-issues.service.zsh"
# zi light zdharma/zsh-github-issues

### end gallery

