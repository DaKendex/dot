
plugins=(
  git
  zsh-autosuggestions
  colored-man-pages
  colorize
)

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
export ZSH="$HOME/.oh-my-zsh"

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


source_if_exists $HOME/.env.sh
source_if_exists $DOTFILES/zsh/alias.zsh
source_if_exists $ZSH/oh-my-zsh.sh

# 1Password setup
source_if_exists $HOME/.config/op/plugins.sh

# Banner MOTD
sh_if_exists $HOME/.config/motd.sh


# Enabling Plugins (zsh-autosuggestions)
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
source_if_exists ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# Enable Z 
# brew install z
source_if_exists "$(brew --prefix)/etc/profile.d/z.sh"


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
