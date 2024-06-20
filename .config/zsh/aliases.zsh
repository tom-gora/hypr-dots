# ALIASES ~~~~~~~~~~~~~~~~~~~~~~

# fixes for XDG locations changes
alias adb="HOME=$XDG_DATA_HOME/android adb"
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"


# configure zshrc
alias zshconfig="nvim $ZDOTDIR/.zshrc"
alias src="source $ZDOTDIR/.zshrc"

#alias my-nvim="NVIM_APPNAME=my-nvim nvim"
# other nvim aliases
alias vi="nvim"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# print project trees ignoring unwanted dirs
alias ptree="tree -I 'node_modules|bin|obj|.git|.vscode|.idea|.vs|__pycache__|target|build|dist|out'"

# eza instead of ls
alias ll="eza -l --group-directories-first --group --header --icons always"
alias ls="eza -1 --group-directories-first --icons always"
alias la="eza -la --group-directories-first --icons always"
alias ld="eza -lD --group-directories-first --icons always"

# bat instead of cat
alias cat="bat"

# quick open
alias xo="xdg-open"

# php-server
# alias php-server="php-server"
# navigation improvements

alias hh="cd $HOME"
alias rr="cd /"
alias cfg="cd $XDG_CONFIG_HOME"
alias ....="../.."
alias ......="../../.."
alias ........="../../../.."
alias qq="exit"
alias xx="exit"
# go to repos
alias rep="cd ~/Repos"
# go to root of apache server
alias aa="cd /var/www/html/"

alias uni="cd ~/Documents/uni_dir/"

# utils etc.
alias fzf-here='fzfgrep_func() { grep -rl "$1" . | fzf | xargs -r nvim; }; fzfgrep_func'

# for school quickly handle dotnet
alias .r="dotnet run ."
alias .br="dotnet build && echo '\n\033[1;35mOutput >>>>>>> \033[0m\n' && dotnet run ."
alias .b="dotnet build"

# applications aliases
#alias code="codium"
alias ferdium="flatpak run org.ferdium.Ferdium %U"
alias cpwd="pwd | wl-copy"
alias cpl="fc -ln -1 | wl-copy"
alias ungoogled="flatpak run com.github.Eloston.UngoogledChromium %U"
alias intellij="/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=idea com.jetbrains.IntelliJ-IDEA-Ultimate"
alias clients="hyprctl clients"

#shortcuts for permission fixes for apps:
alias fix-code="sudo chown -R $(whoami) /usr/share/codium"
alias fix-spicetify="sudo chmod a+wr /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify && sudo chmod a+wr -R /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps && spicetify backup apply"

# FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~

# edit neovim configs
function cfgn() {
  cd "$XDG_CONFIG_HOME/nvim/lua/" && nvim .
}

# edit hyprland configs
function cfgh() {
  cd "$HOME/.config/hypr" && nvim .
}

