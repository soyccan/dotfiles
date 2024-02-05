# Adapted from colored-man-pages plugin in ohmyzsh:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh

function colored
  # Remap the bold & underline text to red & green, respectively
  # See termcap(5), terminfo(5), tput(1) & https://unix.stackexchange.com/a/108840
  # bold & blinking mode
  set less_termcap_mb (set_color --bold red)  # start blinking
  set less_termcap_md (set_color --bold red)  # start bold
  set less_termcap_me (set_color normal)  # end bold & blink
  # standout mode
  set less_termcap_so (begin; set_color --bold black; set_color --background brmagenta; end)  # start standout
  set less_termcap_se (set_color normal)  # end standout
  # underlining
  set less_termcap_us (set_color --bold --italics yellow)  # start underlining
  set less_termcap_ue (set_color normal)  # end underlining

  set environment
  set -a environment "LESS_TERMCAP_mb=$less_termcap_mb"
  set -a environment "LESS_TERMCAP_md=$less_termcap_md"
  set -a environment "LESS_TERMCAP_me=$less_termcap_me"
  set -a environment "LESS_TERMCAP_so=$less_termcap_so"
  set -a environment "LESS_TERMCAP_se=$less_termcap_se"
  set -a environment "LESS_TERMCAP_us=$less_termcap_us"
  set -a environment "LESS_TERMCAP_ue=$less_termcap_ue"
  set -a environment "GROFF_NO_SGR=1"

  env $environment $argv
end

# Colorize man
function man
  colored (command -s man) $argv
end
