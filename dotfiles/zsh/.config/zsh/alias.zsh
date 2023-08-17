alias zshconfig="code ~/.zshrc"
alias s="source ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias copy="pbcopy"
alias ipe="curl wtfismyip.com/json"
alias myip="ifconfig | grep broadcast"
alias tf="op run -- terraform"
alias gconfig="gcloud config configurations activate"
alias up="git fetch --all && git merge "
alias goland="/usr/local/bin/goland"
alias vim="nvim"
alias gproject="gcloud config set project"
alias glist="gcloud compute instances list"
alias gla="git log --oneline"
alias trigger="git commit --allow-empty -m 'trigger'"
alias lv="lvim"


# ls to exa
# alias l='exa -lah --color=auto --icons'

# JWT Decoder
jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}
