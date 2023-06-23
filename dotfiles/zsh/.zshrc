# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

export ZAP_GIT_PREFIX="personalgit:"
plug "zsh-users/zsh-autosuggestions"
plug "MichaelAquilina/zsh-you-should-use"
plug "zap-zsh/supercharge"
plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"
plug "$HOME/.env.sh"
plug "$HOME/.config/zsh/git.zsh"
plug "$HOME/.config/zsh/alias.zsh"

# Load and initialise completion system
autoload -Uz compinit
compinit

# plugins=(
#   git
#   zsh-autosuggestions
#   colored-man-pages
#   colorize
# )

# Functions 
source_if_exists () {
  if test -r "$1"; then
    source "$1"
  fi
}

sh_if_exists () {
  if test -r "$1"; then
    sh "$1"
  fi
}


# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# User configuration
export PATH="/usr/local/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# Gcloud path setup
export PATH=$PATH:"$(dirname $(readlink -f $(command -v gcloud)))"
source_if_exists ~/.config/gcloud/.generate_cloud_configs.zshrc
source_if_exists "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source_if_exists "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# Go path setup
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"


# tmux path setup
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH


# source_if_exists $HOME/.env.sh
# source_if_exists $HOME/.config/zsh/alias.zsh
# source_if_exists $ZSH/oh-my-zsh.sh

# 1Password setup
source_if_exists $HOME/.config/op/plugins.sh

# Banner MOTD
sh_if_exists $HOME/.config/motd.sh


# Enabling Plugins (zsh-autosuggestions)
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
# source_if_exists ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# Enable Z 
# brew install z
# source_if_exists "$(brew --prefix)/etc/profile.d/z.sh"
#
# brew install zoxide
eval "$(zoxide init zsh)"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

precmd() {
  source_if_exists $DOTFILES/zsh/alias.zsh
}

# Use Starship Config
eval "$(starship init zsh)"
