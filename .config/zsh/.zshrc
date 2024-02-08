# XDG locations variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Sourcing the config modules
source_if_exists () {
  if test -r "$1"; then
    source "$1"
  fi
}


source_if_exists $XDG_CONFIG_HOME/zsh/main.zsh
source_if_exists $XDG_CONFIG_HOME/zsh/exports.zsh
source_if_exists $XDG_CONFIG_HOME/zsh/p10k_configs.zsh
source_if_exists $XDG_CONFIG_HOME/zsh/aliases.zsh
source_if_exists $XDG_CONFIG_HOME/zsh/plugins.zsh

zstyle ':omz:update' mode reminder  # remind me to update when it's time
source_if_exists $ZSH/oh-my-zsh.sh

# Source aliases on each prompt
precmd() {
  source $XDG_CONFIG_HOME/zsh/aliases.zsh
}


# The following lines were added by compinstall
zstyle :compinstall filename '/home/tomeczku/.config/zsh/.zshrc'

autoload -Uz compinit promptinit
compinit
# End of lines added by compinstall
