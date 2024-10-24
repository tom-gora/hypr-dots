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

. "/home/tomeczku/.config/cargo/env"
