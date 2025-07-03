alias zshconfig="nvim ${ZDOTDIR}/.zshrc"
alias s="source ${ZDOTDIR}/.zshrc"
alias copy="pbcopy"
alias ipe="curl wtfismyip.com/json"
alias myip="ifconfig | grep broadcast"
# alias tf="op run -- terraform"
alias tf="terraform"
alias tfp="terraform plan -refresh=false"
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

  if [[ -z "$branch" ]]; then
    local options=(
      "feature: For new features (e.g., feature/add-login-page)"
      "bugfix: For bug fixes (e.g., bugfix/fix-header-bug)"
      "hotfix: For urgent fixes (e.g., hotfix/security-patch)"
      "release: For branches preparing a release (e.g., release/v1.2.0)"
      "chore: For non-code tasks like dependency updates (e.g., chore/update-dependencies)"
      "main: Use main branch"
      "custom: Enter a custom branch name"
    )

    local selected=$(printf "%s\n" "${options[@]}" | fzf --height=40% --layout=reverse --prompt="Select branch type: " --header="Branch Naming Convention: <type>/<description>" --preview="echo {}" --preview-window=up:3:wrap)

    local branch_type=$(echo "$selected" | cut -d: -f1)

    if [[ "$branch_type" == "custom" ]]; then
      echo -n "Enter custom branch name: "
      read -r branch
    elif [[ "$branch_type" == "main" ]]; then
      branch="main"
    else
      echo -n "Enter description (without spaces, use hyphens): "
      read -r description

      branch="${branch_type}/${description}"
    fi

    if [[ -z "$branch" ]]; then
      echo "No branch specified. Exiting."
      return 1
    fi
  fi

  local safe_branch=$(echo "$branch" | tr '/' '-')
  local worktree_path="$repo_root/.wt/$safe_branch"

  [ ! -d "$repo_root/.wt" ] && mkdir -p "$repo_root/.wt"

  if git show-ref --verify --quiet refs/heads/"$branch"; then
    git worktree add "$worktree_path" "$branch"
  else
    git worktree add -b "$branch" "$worktree_path"
  fi

  zoxide add "$worktree_path"

  echo "Worktree created at $worktree_path"
  echo "Use 'z $(basename $worktree_path)' to jump to this worktree"
}

# ls to exa
# alias l='exa -lah --color=auto --icons'

# JWT Decoder
jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<<$1
}
