# ALIASES ~~~~~~~~~~~~~~~~~~~~~~

# fixes for XDG locations changes
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

# configure zshrc
alias zshconfig="nvim $ZDOTDIR/.zshrc"
alias src="source $ZDOTDIR/.zshrc"

# alias vi="NVIM_APPNAME=my-nvim nvim"
# other nvim aliases
alias nvim="TERM=wezterm nvim"
alias vi="nvim"

# eza instead of ls
alias ll="eza -l --group-directories-first --group --header --icons always"
alias ls="eza -1 --group-directories-first --icons always"
alias la="eza -la --group-directories-first --icons always"
alias ld="eza -lD --group-directories-first --icons always"
alias tree="eza --tree"

#quick fetch
alias ff="fastfetch"

# one letter away from yazi
alias y="yazi"

# quick lazygit
# alias lg="lazygit"

# quick lazydocker
alias ldo="lazydocker"

#specify picker if using pastel
alias pick="pastel --color-picker hyprpicker pick"

# bat instead of cat
alias cat="bat"

#zoxide instead of cd
alias cd="z"

# quick open
alias xo="xdg-open"
# shallow clone
alias gc1="git clone --depth 1"

#tmux autoname session
alias t='tmux new -A -s "$(basename "$PWD")-$(date +%y%m%d%H%M)"'
alias tns='tmux new-session -s'
alias tas='tmux attach -t'
alias tls='tmux ls'
alias txs="tmux kill-session -t"
alias td='tmux detach'

alias trestore='pgrep -vx tmux > /dev/null && \
                  tmux new -d -s delete-me && \ 
                  tmux run-shell $XDG_CONFIG_HOME/tmux/plugins/tmux-resurrect/scripts/restore.sh && \
                  tmux kill-session -t delete-me && \
                  tmux attach || tmux attach'

# easier dir removal
# soft
alias rmr="rm -r"
# forced
alias rmf="rm -rf"

#colored commands
alias grep="grep --color=auto"

#shorter php artisan
alias pa="php artisan"

#shorter composer dev server
alias crd="composer run dev"

# wezterm img preview
alias wi="wezterm imgcat"

# navigation improvements

alias hh="cd $HOME"
alias ~="cd $HOME"
alias /="cd /"
alias rr="cd /"
alias cfg="cd $XDG_CONFIG_HOME"
alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."
alias ........="cd ../../../.."
alias qq="exit"
alias xx="exit"
# go to repos
alias rep="cd ~/Repos"
# go to root of apache server
alias aa="cd /var/www/html/"

alias uni="cd ~/Documents/uni_dir/"

# utils etc.
alias zel="$XDG_CONFIG_HOME/hypr/scripts/rofi/ZellijSessions.sh -t1"

# for school quickly handle dotnet
alias .r="dotnet run ."
alias .br="dotnet build && echo '\n\033[1;35mOutput >>>>>>> \033[0m\n' && dotnet run ."
alias .b="dotnet build"

# applications aliases
alias spotify="flatpak run --socket=wayland com.spotify.Client --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto &"
alias code="codium --ozone-platform=wayland"
alias cpwd="pwd | wl-copy"
alias cpl="fc -ln -1 | wl-copy"
alias intellij="/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=idea com.jetbrains.IntelliJ-IDEA-Ultimate"
alias clients="hyprctl clients -j | less"

#shortcuts for permission fixes for apps:
alias fix-code="sudo chown -R $(whoami) /usr/share/codium"
