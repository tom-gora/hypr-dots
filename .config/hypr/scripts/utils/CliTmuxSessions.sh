#!/bin/bash

# kickstart tmux with a temp named session to the run the ressurect restoration having the server running
if ! pgrep -vx tmux >/dev/null || [[ $(tmux list-sessions 2>/dev/null | wc -l) -eq 0 ]]; then
	tmux new -d -s delete-me &&
		tmux run-shell "$HOME"/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh
fi

# after ressurect ditch the temp session
tmux kill-session -t delete-me

# func to pick from fzf and call the session managager to attach to session
function call_sesh {
	local choice="$(sesh list --icons | fzf \
		--no-sort --ansi --height=16 --min-height=16 --border=rounded --border-label '󱗿 SESH ' \
		--margin=0,16% \
		--border-label-pos=4 --prompt '  ' \
		--header '  ^e everything ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
		--color=bg:#07060a,fg:#c4a7e7,hl:#ea9a97,selected-fg:#e0def4 \
		--color=fg+:bright-white,bg+:#2e2a42,hl+:#ea9a97,gutter:-1,selected-fg:#e0def4 \
		--color=border:#3e8fb0,header:#3e8fb0,border:bold \
		--color=spinner:#f6c177,info:#9ccfd8,separator:#44415a \
		--color=pointer:#abe9b3,marker:#eb6f92,prompt:#908caa \
		--bind 'ctrl-j:down,ctrl-k:up,ctrl-a:accept-non-empty' \
		--bind 'ctrl-e:change-prompt(  )+reload(sesh list --icons)' \
		--bind 'ctrl-t:change-prompt(  )+reload(sesh list -t --icons)' \
		--bind 'ctrl-g:change-prompt(  )+reload(sesh list -c --icons)' \
		--bind 'ctrl-x:change-prompt(  )+reload(sesh list -z --icons)' \
		--bind 'ctrl-f:change-prompt(󰍉  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
		--bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(  )+reload(sesh list --icons)')"

	zle reset-prompt >/dev/null 2>&1 || true
	if [[ -n "$choice" ]]; then
		sesh connect "$choice" && return
	else
		exit 1
	fi
}

# clear term then set the offset to print the menu in the middle
clear
for i in $(seq 1 $((($(tput lines) / 2) - 8))); do
	echo ""
done

call_sesh
