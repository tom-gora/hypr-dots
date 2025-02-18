# init ssh-agent
ssha() {
  eval "$(ssh-agent -s)"
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
  nvim "$(pwd)" +Oil
}
if [[ -z "$TMUX" ]]; then
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
fi
