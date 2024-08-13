# XDG locations variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Sourcing the config modules
source_if_exists() {
  if test -r "$1"; then
    source "$1"
  fi
}

source_if_exists "$HOME/.env.zsh"

source_if_exists "$XDG_CONFIG_HOME/zsh/main.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/exports.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/fzf_configs.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/aliases.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/plugins.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/functions.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/binds.zsh"

# The following lines were added by compinstall
zstyle :compinstall filename '/home/tomeczku/.config/zsh/.zshrc'

autoload -Uz compinit promptinit
compinit
# End of lines added by compinstall

eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"
eval "$(zoxide init zsh)"

# exec oh-my-posh with my config
eval "$(oh-my-posh init zsh --config ~/.config/my_omp.json)"
