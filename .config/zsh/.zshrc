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

source_if_exists $HOME/.env.zsh

source_if_exists $XDG_CONFIG_HOME/zsh/main.zsh
source_if_exists $XDG_CONFIG_HOME/zsh/exports.zsh
source_if_exists $XDG_CONFIG_HOME/zsh/p10k_configs.zsh
source_if_exists $XDG_CONFIG_HOME/zsh/aliases.zsh
source_if_exists $XDG_CONFIG_HOME/zsh/plugins.zsh
source_if_exists $XDG_CONFIG_HOME/zsh/functions.zsh


# Source aliases on each prompt
precmd() {
  source $XDG_CONFIG_HOME/zsh/aliases.zsh
}


# The following lines were added by compinstall
zstyle :compinstall filename '/home/tomeczku/.config/zsh/.zshrc'

autoload -Uz compinit promptinit
compinit
# End of lines added by compinstall


# OMZ config
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"

# setup fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.config/zsh/fzf-git.sh/fzf-git.sh 


# source for the below settings
# https://www.josean.com/posts/7-amazing-cli-tools
eval $(thefuck --alias)
eval $(thefuck --alias fk)
eval "$(zoxide init zsh)"

# setup for fzf etc
#
# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ea9a97
	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
	--color=border:#44415a,header:#3e8fb0,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

zstyle ':omz:update' mode reminder  # remind me to update when it's time
source_if_exists $ZSH/oh-my-zsh.sh

source $ZSH/oh-my-zsh.sh
