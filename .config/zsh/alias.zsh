alias zshconfig="code ~/.zshrc"
alias s="source ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias copy="pbcopy"
alias ipe="curl wtfismyip.com/json"
alias myip="ifconfig | grep broadcast"
alias tf="op run -- terraform"
alias tflock="tf init -reconfigure -upgrade && tf providers lock -platform=linux_amd64 -platform=darwin_amd64 -platform=windows_amd64"
alias gconfig="gcloud config configurations activate"
alias up="git fetch --all && git merge "
alias goland="/usr/local/bin/goland"
alias gproject="gcloud config set project"
alias glist="gcloud compute instances list"
alias gla="git log --oneline"
alias glp='git log --pretty=format:"%C(yellow)%h%Creset - %C(green)%an%Creset, %ar : %s"'
alias trigger="git commit --allow-empty -m 'trigger'"
alias idgaf="git commit -m $(curl -s https://whatthecommit.com/index.txt)"
alias vi="nvim"
alias vid="NVIM_APPNAME=nvim-dev nvim "
alias hi="history 1 | fzf"

alias kubectl="kubecolor"
alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
# alias kns="kubectl config set-context --current --namespace "
# alias kctx="kubectl config use-context " # send output to fzf. but dont run automatically when zshrc is sourced. only when called
alias kctx="kubectx"
alias kns="kubens"

alias brew-dump="brew bundle dump --file=~/repo/dot/Brewfile --force"
alias brew-sync="brew bundle --file=~/repo/dot/Brewfile --no-upgrade"
alias brew-clean="brew bundle cleanup --file=~/repo/dot/Brewfile --force"

wta() {
  local branch=$1
  local current_dir=$(pwd)
  local repo_root=$(git rev-parse --show-toplevel)
  local worktree_path="$repo_root/.wt/$branch"

  # Create .wt directory if it doesn't exist
  [ ! -d "$repo_root/.wt" ] && mkdir -p "$repo_root/.wt"

  # Create the worktree
  git worktree add "$worktree_path"

  # Add the worktree path to zoxide's database
  zoxide add "$worktree_path"
  
  # Print confirmation and instructions
  echo "Worktree created at $worktree_path"
  echo "Use 'z $(basename $worktree_path)' to jump to this worktree"
}

# ls to exa
# alias l='exa -lah --color=auto --icons'

# JWT Decoder
jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}
