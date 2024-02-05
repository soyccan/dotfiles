# fzf: fuzzy searcher. https://github.com/z-shell/fzf

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

__fsel_smart() {
  local dir="$1"
  shift

  local cmd="${FZF_CTRL_T_COMMAND:-"command find -L '$dir' -mindepth 1 \\( -path '*/.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --scheme=path --bind=ctrl-z:ignore ${FZF_DEFAULT_OPTS-} ${FZF_CTRL_T_OPTS-}" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

fzf-file-widget-smart() {
  if [[ "${LBUFFER[-1]}" != ' ' ]]; then
    # if a dir prefix is typed when the trigger key is pressed,
    # e.g. $ cat ~/mydir/<cursor>
    # used last word (respecting quotes) in command line as the dir to search in (expands tildes)
    local cmd=(${(@Q)${(z)LBUFFER}})

    # expand tildes
    local dir=${~cmd[-1]}

    # drop the last word in the command line
    local cmd=("${cmd[@]:0:$((${#cmd[@]}-1))}")

    LBUFFER="${(@q)cmd} $(__fsel_smart $dir)"
  else
    LBUFFER="${LBUFFER}$(__fsel)"
  fi
  local ret=$?
  zle reset-prompt
  return $ret
}
zle -N fzf-file-widget-smart
bindkey "^T" fzf-file-widget-smart
