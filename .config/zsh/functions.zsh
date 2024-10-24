# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# serve static php
function php-server() {
  local port
  for ((port = 9000; port <= 65535; port++)); do
    netstat -tln | grep -qE "\b${port}\b"
    if [ $? -ne 0 ]; then
      php -S localhost:$port &
      sleep 1
      xdg-open http://localhost:$port &
      return 0
    fi
  done

  echo "No available ports in the range 9000-65535."
  return 1
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
