#fix delete button
bindkey '^[[3~' delete-char

# ctrl-space to quickly open pwd in nvim
bindkey -s '^ ' 'nvim .\n'

# ctrl-a accepts autosuggestion
bindkey '^a' autosuggest-accept

# cycle throught hist relevant to command
bindkey '^z' history-search-backward
bindkey '^x' history-search-forward
