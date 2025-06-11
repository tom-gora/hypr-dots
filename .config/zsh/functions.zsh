# wrapper for lazygit to init ssh-agent
lg() {
  local IS_AGENT IS_IDENTIFIED FIRST_AVAILABLE
  IS_AGENT="$(pgrep -u "$USER" ssh-agent)"
  local PRIMARY_SSH_KEY="$HOME/.ssh/github_auth_primary"
  local FALLBACK_SSH_KEY="$HOME/.ssh/github_auth_fallback"

  if [ -f "$PRIMARY_SSH_KEY" ]; then
    FIRST_AVAILABLE="$PRIMARY_SSH_KEY"
  else
    if [ -f "$FALLBACK_SSH_KEY" ]; then
      FIRST_AVAILABLE="$FALLBACK_SSH_KEY"
    else
      echo "No SSH keys found. Exiting."
      return 1
    fi
  fi

  if [ -z "$IS_AGENT" ]; then
    echo "SSH agent not running. Should have been bootstraped with the shell."
    echo -e "Run \`eval \"\$(ssh-agent -s)\"\` to start it. Investigate why not running."
    return 1
  fi

  IS_IDENTIFIED=$(ssh-add -l | grep "goratomasz@outlook.com")

  if [ -z "$IS_IDENTIFIED" ] && [ -f "$FIRST_AVAILABLE" ]; then
    /usr/bin/ssh-add "$FIRST_AVAILABLE" &&
      lazygit
  else
    lazygit
  fi
}

# edit neovim configs
function cfgn() {
  cd "$XDG_CONFIG_HOME/nvim/lua/" && nvim .
}

# edit hyprland configs
function cfgh() {
  cd "$HOME/.config/hypr" && nvim .
}
# additional clearing bind to make it work in nvim which occupies C-L
function clear-screen-and-scrollback() {
  builtin echoti civis >"$TTY"
  builtin print -rn -- $'\e[H\e[2J' >"$TTY"
  builtin zle .reset-prompt
  builtin zle -R
  builtin print -rn -- $'\e[3J' >"$TTY"
  builtin echoti cnorm >"$TTY"
}
zle -N clear-screen-and-scrollback
bindkey "^[^l" clear-screen-and-scrollback

function new-script() {
  SCRIPT_NAME=$1
  touch "$SCRIPT_NAME" && chmod u+x "$SCRIPT_NAME"
}

function nvim_here() {
  nvim "$(pwd)"
}

# if [[ -z "$TMUX" ]]; then
function my_sesh_call() {
  {
    exec </dev/tty
    exec <&1
    local choice="$(sesh list --icons | fzf \
      --no-sort --ansi --height=16 --min-height=16 --border=rounded --border-label '󱗿 SESH ' \
      --border-label-pos=4 --prompt '  ' \
      --header '  ^e everything ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
      --bind 'ctrl-j:down,ctrl-k:up,ctrl-a:accept-non-empty' \
      --bind 'ctrl-e:change-prompt(  )+reload(sesh list --icons)' \
      --bind 'ctrl-t:change-prompt(  )+reload(sesh list -t --icons)' \
      --bind 'ctrl-g:change-prompt(  )+reload(sesh list -c --icons)' \
      --bind 'ctrl-x:change-prompt(  )+reload(sesh list -z --icons)' \
      --bind 'ctrl-f:change-prompt(󰍉  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(  )+reload(sesh list --icons)')"

    zle reset-prompt >/dev/null 2>&1 || true
    [[ -z "$choice" ]] && return
    sesh connect "$choice"
  }
}
# fi
