# language environment
export LANG=GB.UTF-8
export LC_CTYPE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# XDG ninja fixes
export ANDROID_HOME="$XDG_DATA_HOME/android"
export ANDROID_AVD_HOME="$HOME/.var/app/com.google.AndroidStudio/config/.android/avd"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GOPATH="$XDG_CONFIG_HOME/go"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# Get rid of unfinished line markers in C
export PROMPT_EOL_MARK=""

# Add Java to path
CLASSPATH=/lib/jvm/java-17-openjdk-17.0.9.0.9-3.fc39.x86_64/bin

# Local binaries in path
export PATH="$HOME/.local/bin":$PATH
export PATH="/usr/local/bin":$PATH
export PATH="$HOME/.local/bin/.spicetify":$PATH
export PATH="$HOME/Android/Sdk/emulator:$HOME/Android/Sdk/platform-tools:$HOME/Android/Sdk/tools/bin":$PATH
export PATH="$HOME/.config/cargo/bin":$PATH

# Manpath
export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

# Force bat theme
export BAT_THEME='rose-pine-moon'

# Preferred browser
# export BROWSER="one.ablaze.floorp.desktop"

# some wayland fixes
export HSA_OVERRIDE_GFX_VERSION=10.3.0

export MOZ_ENABLE_WAYLAND=1

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
