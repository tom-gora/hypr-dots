#fix delete button
bindkey '^[[3~' delete-char

# ctrl-a accepts autosuggestion
bindkey '^a' autosuggest-accept

# rebind this default to free up "t"
bindkey -r '^t'
bindkey '^f' fzf-file-widget

zle -N my_sesh_call
# for the sesh tmux session manager
bindkey '^[T' my_sesh_call

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
# bindkey -r "^L" # that's ok - sending "clear" now via prefix c-l
bindkey -r "^N"

if [[ -n "$TMUX" ]]; then
  export TMUX_ZSH_POPUP="#{@popup-toggle} \
-Ed'#{pane_current_path}' \
-w80% -h80% \
-T '  zsh ' \
--name=zsh \
zsh"

  tmux_shell_popup_widget() {
    tmux run "$TMUX_ZSH_POPUP"
    zle redisplay # Refresh the prompt after running the command
  }

  zle -N tmux_shell_popup_widget

  bindkey '^T' tmux_shell_popup_widget
fi
