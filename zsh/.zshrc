# Created by Zap installer zapzsh.org
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

export ZAP_GIT_PREFIX="git@github.com:"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "MichaelAquilina/zsh-you-should-use"
plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"
plug "jeffreytse/zsh-vi-mode"
# plug "chrishrb/zsh-kubectl"
plug "zsh-users/zsh-history-substring-search"
# plug "softmoth/zsh-vim-mode"
plug "$HOME/.env.zsh"
# plug "$HOME/.cargo/env"
plug "$HOME/.config/zsh/git.zsh"
plug "$HOME/.config/zsh/alias.zsh"
plug "$HOME/.config/zsh/colima.zsh"
plug "$HOME/.config/zsh/lg.zsh"
plug "$HOME/.config/zsh/aws.zsh"
plug "$HOME/.config/zsh/options.zsh"
plug "$HOME/.config/op/plugins.sh"

# history
export HISTSIZE=110000
export SAVEHIST=100000
export HISTFILE=~/.histfile

setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit 
setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword

# Load and initialise completion system
autoload -Uz compinit
compinit
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
  {
    echo "Load starship"
    eval "$($(brew --prefix)/bin/starship init zsh)"
  }

# zmodload zsh/terminfo
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
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

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey -M vicmd 'v' edit-command-line

# Functions 
sh_if_exists () {
  if test -r "$1"; then
    sh "$1"
  fi
}

# Banner MOTD
sh_if_exists $HOME/.config/bin/motd/motd.sh


# User configuration
export PATH="/usr/local/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH

# export homebrew path
export PATH="/opt/homebrew/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

# Go path setup
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"


# brew zsh completion: https://github.com/eza-community/eza#for-zsh-with-homebrew
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# brew install zoxide
eval "$(zoxide init zsh)"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='vi'
fi
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

source <(fzf --zsh)

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
