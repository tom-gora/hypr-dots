# .bashrc

export EDITOR='nvim'
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export HISTFILE="$XDG_STATE_HOME/bash/history"
export TERMINAL="wezterm"

#cargo setup
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export PATH="$CARGO_HOME/bin":$PATH
source "$CARGO_HOME/env"

export PATH="$HOME/.local/bin":$PATH
export PATH="/usr/local/bin":$PATH

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export PATH="$HOME/.local/bin":$PATH
export PATH="/usr/local/bin":$PATH
export PATH="/usr/bin":$PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

export FZF_DEFAULT_OPTS="
	--color=bg:#07060a,fg:#c4a7e7,hl:#ea9a97,selected-fg:#e0def4
	--color=fg+:bright-white,bg+:#2e2a42,hl+:#ea9a97,gutter:-1,selected-fg:#e0def4
	--color=border:#3e8fb0,header:#3e8fb0,border:bold
	--color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
	--color=pointer:#abe9b3,marker:#eb6f92,prompt:#908caa
  --preview-window right:60%:wrap
  --bind ctrl-p:toggle-preview
  --bind ctrl-j:down,ctrl-k:up,ctrl-a:accept-non-empty"

. "/home/tomeczku/.config/cargo/env"
