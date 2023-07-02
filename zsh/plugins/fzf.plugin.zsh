# fzf: fuzzy searcher. https://github.com/z-shell/fzf
# fasd: access recently used files/dirs. https://github.com/clvv/fasd

# Default key bindings by fzf:
#   ^R : paste selected command histo(r)y into command line
#   ^T : paste selected file under current dir (t)ree into command line
#   ALT-C / <ESC>+c : (c)d into selected dir under current tree

# My key bindings:
#   ^G : 1. (g)oto recent dir
#        2. paste selected file from recently used files into command line

# This file requires fzf/shell/key-bindings.zsh to be loaded first
# Reference:
# - https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
# - https://github.com/wookayin/fzf-fasd/blob/master/fzf-fasd.plugin.zsh

fzf-fasd-widget() {
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
zle -N fzf-fasd-widget
bindkey "^G" fzf-fasd-widget

fzf-file-widget-smarter() {
  setopt localoptions pipefail no_aliases 2> /dev/null

  if [[ "${LBUFFER[-1]}" = ' ' ]]; then
    # fallback to cwd
    local dir=.
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
    echo -n "${${(q)item#./}#${dir}} "
  done)"
  local ret=$?

  LBUFFER="${LBUFFER}${files}"
  zle reset-prompt
  return $ret
}
zle -N fzf-file-widget-smarter
bindkey "^T" fzf-file-widget-smarter

