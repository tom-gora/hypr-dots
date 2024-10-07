# Lines configured by zsh-newuser-install
HISTFILE="$XDG_CONFIG_HOME/zsh/.zsh_history"
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt extendedglob nomatch
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newu ser-install
