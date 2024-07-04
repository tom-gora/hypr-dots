# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tomeczku/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tomeczku/.fzf/bin"
fi

source <(fzf --zsh)
