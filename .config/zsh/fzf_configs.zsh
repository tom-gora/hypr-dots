# source for many of the settings
# https://www.josean.com/posts/7-amazing-cli-tools
#
# setup fzf
eval "$(fzf --zsh)"
# setup for fzf etc
export FZF_DEFAULT_OPTS="
  --multi
  --cycle
  --bind ctrl-a:accept-non-empty
	--color=bg:#050407,fg:#495057,hl:#665662,selected-fg:#ced4da
	--color=fg+:bright-white,bg+:#212529,hl+:#665662,gutter:-1,selected-fg:#ced4da
	--color=border:#475B67,header:#475B67,border:bold
	--color=spinner:#887963,info:#495057,separator:#343a40
	--color=pointer:#6D8878,marker:#755867,prompt:#908caa
  --preview-window right:60%:wrap
  --bind ctrl-p:toggle-preview
  --bind ctrl-j:down,ctrl-k:up,ctrl-a:accept-non-empty"

export FZF_COMPLETION_TRIGGER="\`\`"

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git --exclude node_modules"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git --exclude node_modules"

SHOW_FILE_OR_DIR_PREVIEW="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--multi --cycle  --preview '$SHOW_FILE_OR_DIR_PREVIEW'"
export FZF_ALT_C_OPTS="--multi --cycle  --preview 'eza --tree --color=always {} | head -200'"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
# # Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
