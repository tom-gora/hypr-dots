# bootstrap zinint plugin manager

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit ice depth=1
zinit light Aloxaf/fzf-tab
zinit ice depth=1
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice depth=1
zinit light zsh-users/zsh-completions
zinit ice depth=1
zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1
zinit light lukechilds/zsh-better-npm-completion
# zinit light jeffreytse/zsh-vi-mode # causing conflicts so disabled for the time

# Add in oh-my-zsh snippets
zinit snippet OMZP::colorize
zinit snippet OMZP::dnf
zinit snippet OMZP::extract
zinit snippet OMZP::gitignore

#reload completions
autoload -Uz compinit && compinit

zinit cdreplay -q

#artisan completions
zinit ice depth=1
zinit light jessarcher/zsh-artisan

# configs
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
#ignore this one as I use t for my own function elsewhere
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-space:ignore'
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-l:accept-non-empty'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept

#zsh-completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
