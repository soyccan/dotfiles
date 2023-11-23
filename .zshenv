# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# In Ubuntu, skip the compinit in /etc/zsh/zshrc
# [Bug #16759 “compinit -U in /etc/zsh/zshrc is unfriendly to fpath users” : Bugs : zsh package : Ubuntu](https://bugs.launchpad.net/ubuntu/+source/zsh/+bug/16759)
skip_global_compinit=1
