# Reference: 
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Use emacs key bindings
bindkey -e

# [PageUp] - Up a line of history
if [[ -n "${key[PageUp]}" ]]; then
  bindkey -M emacs "${key[PageUp]}" up-line-or-history
  bindkey -M viins "${key[PageUp]}" up-line-or-history
  bindkey -M vicmd "${key[PageUp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${key[PageDown]}" ]]; then
  bindkey -M emacs "${key[PageDown]}" down-line-or-history
  bindkey -M viins "${key[PageDown]}" down-line-or-history
  bindkey -M vicmd "${key[PageDown]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${key[Up]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M emacs "${key[Up]}" up-line-or-beginning-search
  bindkey -M viins "${key[Up]}" up-line-or-beginning-search
  bindkey -M vicmd "${key[Up]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${key[Down]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M emacs "${key[Down]}" down-line-or-beginning-search
  bindkey -M viins "${key[Down]}" down-line-or-beginning-search
  bindkey -M vicmd "${key[Down]}" down-line-or-beginning-search
fi

# Start typing + Ctrl-P - fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey -M emacs "^P" up-line-or-beginning-search
bindkey -M viins "^P" up-line-or-beginning-search
bindkey -M vicmd "^P" up-line-or-beginning-search

# Start typing + Ctrl-N - fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M emacs "^N" down-line-or-beginning-search
bindkey -M viins "^N" down-line-or-beginning-search
bindkey -M vicmd "^N" down-line-or-beginning-search

# [Home] - Go to beginning of line
if [[ -n "${key[Home]}" ]]; then
  bindkey -M emacs "${key[Home]}" beginning-of-line
  bindkey -M viins "${key[Home]}" beginning-of-line
  bindkey -M vicmd "${key[Home]}" beginning-of-line
fi
# All possible sequence of Home
for seq in $'\e[1~' $'\e[1;2H' $'\eOH'; do
    bindkey -M emacs "$seq" beginning-of-line
    bindkey -M viins "$seq" beginning-of-line
    bindkey -M vicmd "$seq" beginning-of-line
done
# [End] - Go to end of line
if [[ -n "${key[End]}" ]]; then
  bindkey -M emacs "${key[End]}"  end-of-line
  bindkey -M viins "${key[End]}"  end-of-line
  bindkey -M vicmd "${key[End]}"  end-of-line
fi
# All possible sequence of End
for seq in $'\e[4~' $'\e[1;2F' $'\eOF'; do
    bindkey -M emacs "$seq" end-of-line
    bindkey -M viins "$seq" end-of-line
    bindkey -M vicmd "$seq" end-of-line
done

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${key[Delete]}" ]]; then
  bindkey -M emacs "${key[Delete]}" delete-char
  bindkey -M viins "${key[Delete]}" delete-char
  bindkey -M vicmd "${key[Delete]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char

  bindkey -M emacs "^[3;5~" delete-char
  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word


bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey ' ' magic-space                               # [Space] - don't do history expansion


# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# file rename magick
bindkey "^[m" copy-prev-shell-word

# consider emacs keybindings:

#bindkey -e  ## emacs key bindings
#
#bindkey '^[[A' up-line-or-search
#bindkey '^[[B' down-line-or-search
#bindkey '^[^[[C' emacs-forward-word
#bindkey '^[^[[D' emacs-backward-word
#
#bindkey -s '^X^Z' '%-^M'
#bindkey '^[e' expand-cmd-path
#bindkey '^[^I' reverse-menu-complete
#bindkey '^X^N' accept-and-infer-next-history
#bindkey '^W' kill-region
#bindkey '^I' complete-word
## Fix weird sequence that rxvt produces
#bindkey -s '^[[Z' '\t'
