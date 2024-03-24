# Created by Zap installer zapzsh.org
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

export ZAP_GIT_PREFIX="git@github.com:"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "MichaelAquilina/zsh-you-should-use"
plug "zap-zsh/exa"
plug "chrishrb/zsh-kubectl"
plug "unixorn/fzf-zsh-plugin"
plug "zsh-users/zsh-syntax-highlighting"
plug "chrishrb/zsh-kubectl"
plug "zsh-users/zsh-history-substring-search"
plug "softmoth/zsh-vim-mode"
plug "$HOME/.env.sh"
# plug "$HOME/.cargo/env"
plug "$HOME/.config/zsh/git.zsh"
plug "$HOME/.config/zsh/alias.zsh"
plug "$HOME/.config/zsh/colima.zsh"
plug "$HOME/.config/zsh/options.zsh"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Use Starship Config
eval "$(starship init zsh)"

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

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


# Banner MOTD
sh_if_exists $HOME/.config/motd.sh


# User configuration
export PATH="/usr/local/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH

# export homebrew path
export PATH="/opt/homebrew/bin:$PATH"
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

# brew zsh completion: https://github.com/eza-community/eza#for-zsh-with-homebrew
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# 1Password setup
source_if_exists $HOME/.config/op/plugins.sh

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

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# # YubiKey - Disable OTP
# # https://support.yubico.com/hc/en-us/articles/360013714379-Accidentally-Triggering-OTP-Codes-with-Your-Nano-YubiKey
# if ! [[ $(which ykman) ]]; then
#   brew install ykman
# fi
# for serial in $(ykman list -s); do
#   echo "Disabling OTP for Serial $serial"
#   ykman --device $serial config usb --disable OTP --force
#   echo "--- $serial ---" 
#   ykman --device $serial info
#   echo
# done
export GPG_TTY=$(tty)
ave () {
  # usage: ave {profile}
  profile=${1:-dev}
  aws-vault exec $profile -- zsh
}
