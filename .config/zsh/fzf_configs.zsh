# source for many of the settings
# https://www.josean.com/posts/7-amazing-cli-tools
#
# setup fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# setup for fzf etc
# -- MINE: setup rose-pine colors for fzf --
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ea9a97
	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
	--color=border:#44415a,header:#3e8fb0,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

 export FZF_COMPLETION_TRIGGER="~~"

 # -- Use fd instead of fzf --
 export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
 export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
 export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
 export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
 export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

 _fzf_compgen_path() {
   fd --hidden --exclude .git . "$1"
 }

 # Use fd to generate the list for directory completion
 _fzf_compgen_dir() {
   fd --type=d --hidden --exclude .git . "$1"
 }
 show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

 export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
 export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

 # Advanced customization of fzf options via _fzf_comprun function
 # - The first argument to the function is the name of the command.
 # - You should make sure to pass the rest of the arguments to fzf.
 _fzf_comprun() {
   local command=$1
   shift

   case "$command" in
     cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
     export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
     ssh)          fzf --preview 'dig {}'                   "$@" ;;
     *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
   esac
 }