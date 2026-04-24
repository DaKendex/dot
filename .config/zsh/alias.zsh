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

wtmainup() {
  local default_branch
  local branch
  local worktree_info
  local target_worktree
  local remote_ref

  command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
    echo "wtmainup: not inside a git worktree"
    return 1
  }

  command git fetch origin --prune "+refs/heads/*:refs/remotes/origin/*" || return 1

  default_branch=$(command git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)
  default_branch="${default_branch#origin/}"

  if [[ -z "$default_branch" ]]; then
    for branch in develop master main trunk mainline default; do
      if command git show-ref -q --verify "refs/remotes/origin/$branch" \
        || command git show-ref -q --verify "refs/heads/$branch"; then
        default_branch="$branch"
        break
      fi
    done
  fi

  if [[ -z "$default_branch" ]]; then
    echo "wtmainup: could not determine the default branch"
    return 1
  fi

  remote_ref="refs/remotes/origin/$default_branch"
  command git show-ref -q --verify "$remote_ref" || {
    echo "wtmainup: could not update $remote_ref"
    return 1
  }

  worktree_info=$(command git worktree list --porcelain 2>/dev/null) || return 1

  target_worktree=$(
    printf '%s\n' "$worktree_info" | awk -v branch="refs/heads/$default_branch" '
      BEGIN { RS = ""; FS = "\n" }
      {
        path = ""
        branch_ref = ""
        is_bare = 0

        for (i = 1; i <= NF; i++) {
          if ($i ~ /^worktree /) {
            path = substr($i, 10)
          } else if ($i ~ /^branch /) {
            branch_ref = substr($i, 8)
          } else if ($i == "bare") {
            is_bare = 1
          }
        }

        if (!is_bare && branch_ref == branch) {
          print path
          exit
        }
      }
    '
  )

  if [[ -n "$target_worktree" ]]; then
    if command git -C "$target_worktree" show-ref -q --verify "refs/heads/$default_branch"; then
      command git -C "$target_worktree" switch "$default_branch" || return 1
    else
      command git -C "$target_worktree" switch --track -c "$default_branch" "origin/$default_branch" || return 1
    fi

    command git -C "$target_worktree" merge --ff-only "$remote_ref" || return 1

    echo "Updated $target_worktree on $default_branch. Rebase with: git rebase origin/$default_branch"
    return 0
  fi

  if command git show-ref -q --verify "refs/heads/$default_branch"; then
    command git merge-base --is-ancestor "refs/heads/$default_branch" "$remote_ref" || {
      echo "wtmainup: $default_branch has local commits and no dedicated default-branch worktree was found"
      return 1
    }

    command git branch -f "$default_branch" "$remote_ref" || return 1
  else
    command git branch "$default_branch" "$remote_ref" || return 1
  fi

  echo "Updated refs for $default_branch. Rebase with: git rebase origin/$default_branch"
}

alias vi="nvim"
alias vid="NVIM_APPNAME=nvim-dev nvim "
alias hi="history 1 | fzf"
alias zad="ls -d */ | xargs -I {} zoxide add {}"

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

# ls to exa
# alias l='exa -lah --color=auto --icons'

# JWT Decoder
jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<<$1
}
