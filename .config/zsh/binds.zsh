#fix delete button
bindkey "^[[3~" delete-char

#quick nvim in dir
open-current-dir-in-nvim() { nvim $(pwd); }
zle -N open-current-dir-in-nvim
bindkey "^@" open-current-dir-in-nvim
