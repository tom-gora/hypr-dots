# setopt PROMPT_SUBST
# zmodload zsh/zprof
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

# The following lines were added by compinstall
zstyle :compinstall filename '/home/tomeczku/.config/zsh/.zshrc'

autoload -U compinit promptinit && compinit
# End of lines added by compinstall

source_if_exists "$XDG_CONFIG_HOME/zsh/main.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/exports.zsh"

# exec prompt after exports and ahead of all the other environment fluff
if [ -n "$SCRATCHPAD" ]; then
  # If SCRATCHPAD is set, load the scratchpad config
  eval "$(oh-my-posh init zsh --config ~/.config/my_scratchpad_omp.json)"
else
  # Otherwise, load the default config
  eval "$(oh-my-posh init zsh --config ~/.config/my_omp.json)"
fi

oh-my-posh enable reload

source_if_exists "$XDG_CONFIG_HOME/zsh/aliases.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/functions.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/plugins.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/binds.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/bootstrap-ssh.zsh"
source_if_exists "$XDG_CONFIG_HOME/zsh/fzf_configs.zsh"

eval "$(zoxide init zsh)"

#reload completions at the very end
autoload -Uz compinit && compinit
