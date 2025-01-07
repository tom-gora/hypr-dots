#fix delete button
bindkey '^[[3~' delete-char

# ctrl-a accepts autosuggestion
bindkey '^a' autosuggest-accept

# rebind this default to free up "t"
bindkey -r '^t'
bindkey '^f' fzf-file-widget

if [[ -z "$TMUX" ]]; then
  zle -N my_sesh_call
  # for the sesh tmux session manager
  bindkey '^t' my_sesh_call
fi

# ctrl-space to quickly open pwd in nvim
zle -N nvim_here
bindkey '^ ' nvim_here

# cycle throught hist relevant to command
bindkey '^z' history-search-backward
bindkey '^x' history-search-forward

#unbind stuff interfering with my nvim
bindkey -r "^H"
bindkey -r "^J"
bindkey -r "^K"
bindkey -r "^L"
bindkey -r "^N"
