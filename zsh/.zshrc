# ==============================
# Essential System Setup
# ==============================
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Load and initialize completion system
autoload -Uz compinit
compinit

# ==============================
# Plugin & Configuration Loading
# ==============================

# Zap plugin manager
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugin list
export ZAP_GIT_PREFIX="git@github.com:"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "MichaelAquilina/zsh-you-should-use"
plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"
plug "jeffreytse/zsh-vi-mode"
plug "zsh-users/zsh-history-substring-search"

# Custom Configs
plug "$HOME/.env.zsh"
plug "$XDG_CONFIG_HOME/zsh/git.zsh"
plug "$XDG_CONFIG_HOME/zsh/bash.zsh"
plug "$XDG_CONFIG_HOME/zsh/alias.zsh"
plug "$XDG_CONFIG_HOME/zsh/colima.zsh"
plug "$XDG_CONFIG_HOME/zsh/lg.zsh"
plug "$XDG_CONFIG_HOME/zsh/aws.zsh"
plug "$XDG_CONFIG_HOME/zsh/k8s.zsh"
plug "$XDG_CONFIG_HOME/zsh/options.zsh"
plug "$XDG_CONFIG_HOME/op/plugins.sh"


# ==============================
# Environment Variables
# ==============================

# User PATH Configuration
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Go Path
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Brew Zsh completion
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# fzf integration
source <(fzf --zsh)

# Zoxide initialization
eval "$(zoxide init zsh)"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='vi'
fi

# Ripgrep (rg) integration with fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# ==============================
# Shell History Configuration
# ==============================

export HISTSIZE=110000
export SAVEHIST=100000
export HISTFILE=~/.histfile

setopt append_history           # Append history
setopt hist_ignore_all_dups     # No duplicate history entries
unsetopt hist_ignore_space      # Ignore space-prefixed commands
setopt hist_reduce_blanks       # Trim blanks
setopt hist_verify              # Show before executing history commands
setopt inc_append_history       # Add commands as they are typed
setopt share_history            # Share history between sessions
setopt bang_hist                # Enable `!keyword` expansion

# ==============================
# Shell Behavior & Keybindings
# ==============================

# Load Starship if necessary
type starship_zle-keymap-select >/dev/null || \
  {
    echo "Load starship"
    eval "$($(brew --prefix)/bin/starship init zsh)"
  }

# History substring search keybindings
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down
bindkey -M vicmd '^[[A' history-substring-search-up 
bindkey -M vicmd '^[OA' history-substring-search-up 
bindkey -M vicmd '^[[B' history-substring-search-down
bindkey -M vicmd '^[OB' history-substring-search-down
bindkey -M viins '^[[A' history-substring-search-up 
bindkey -M viins '^[OA' history-substring-search-up 
bindkey -M viins '^[[B' history-substring-search-down 
bindkey -M viins '^[OB' history-substring-search-down
bindkey -r '^X'

# Edit command line bindings
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey -M vicmd 'v' edit-command-line

# ==============================
# Functions & Scripts
# ==============================

sh_if_exists () {
  if test -r "$1"; then
    sh "$1"
  fi
}

# Banner MOTD
sh_if_exists $HOME/.config/bin/motd/motd.sh

# ==============================
# Command-Line Tools & Utilities
# ==============================

# YubiKey - Disable OTP (Commented Out)
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
