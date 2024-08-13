# ALIASES ~~~~~~~~~~~~~~~~~~~~~~

# fixes for XDG locations changes
alias adb="HOME=$XDG_DATA_HOME/android adb"
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

# configure zshrc
alias zshconfig="nvim $ZDOTDIR/.zshrc"
alias src="source $ZDOTDIR/.zshrc"

# alias vi="NVIM_APPNAME=my-nvim nvim"
# other nvim aliases
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
alias lg="lazygit"

# bat instead of cat
alias cat="bat"

#zoxide instead of cd
alias cd="z"

# quick open
alias xo="xdg-open"

# easier dir removal
# soft
alias rmr="rm -r"
# forced
alias rmf="rm -rf"

# php-server
# alias php-server="php-server"
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
# alias fzf-here='fzfgrep_func() { grep -rl "$1" . | fzf | xargs -r nvim; }; fzfgrep_func'

# for school quickly handle dotnet
alias .r="dotnet run ."
alias .br="dotnet build && echo '\n\033[1;35mOutput >>>>>>> \033[0m\n' && dotnet run ."
alias .b="dotnet build"

# applications aliases
alias spotify="flatpak run --socket=wayland com.spotify.Client --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto &"
alias code="codium"
alias cpwd="pwd | wl-copy"
alias cpl="fc -ln -1 | wl-copy"
alias intellij="/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=idea com.jetbrains.IntelliJ-IDEA-Ultimate"
alias clients="hyprctl clients"

#shortcuts for permission fixes for apps:
alias fix-code="sudo chown -R $(whoami) /usr/share/codium"
alias fix-spicetify="sudo chmod a+wr /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify && sudo chmod a+wr -R /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps && spicetify backup apply"
