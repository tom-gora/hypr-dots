#fix delete button
bindkey '^[[3~' delete-char

# ctrl-a accepts autosuggestion
bindkey '^a' autosuggest-accept

function sesh_fzf_prompt() {
  local selected_session
  selected_session=$(sesh list --icons | fzf-tmux -p 55%,60% \
    --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
    --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
    --bind 'tab:down,btab:up' \
    --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
    --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
    --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
    --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
    --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
    --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)')

  if [[ -n $selected_session ]]; then
    sesh connect "$selected_session"
  fi
}

zle -N sesh_fzf_prompt
bindkey '^s' sesh_fzf_prompt

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
