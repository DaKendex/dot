# Dotfiles

macOS dotfiles managed with GNU Stow. Config for Neovim, Zsh, Tmux, and various CLI tools.

## Key Commands

- **Stow dotfiles**: `stow .` from repo root
- **Brew sync**: `brew bundle --file=Brewfile`
- **Go tests**: `cd .config/bin/dadjoke-go && go test -v`
- **Go build**: `cd .config/bin/dadjoke-go && make build`
- **PlantUML diagrams**: `cd desksetup && make generate`

## Branch Strategy

- `main` — personal configs only, pushed to GitHub
- `work` — local only, work-specific commits rebased on top of `main`; prefix with `work:`

Use `git add -p` to split personal and work changes in the same file before committing.

## Manual Setup (not stow-managed)

- **`ai-session-manager` (tmux `prefix+C` / Ghostty `Cmd+i`)**: picks between running Claude/Codex sessions across tmux, with live status. Claude side needs nothing (reads `claude agents --json` directly). Codex side needs `~/.codex/hooks.json` wired to `codex-session-state` -- that file is a real file outside the stow tree (like `.aws/config`), so a fresh machine needs it created by hand:
  ```json
  {
    "hooks": {
      "SessionStart": [{ "matcher": "", "hooks": [{ "type": "command", "command": "~/.config/bin/codex-session-state idle", "timeout": 10 }] }],
      "UserPromptSubmit": [{ "matcher": "", "hooks": [{ "type": "command", "command": "~/.config/bin/codex-session-state working", "timeout": 10 }] }],
      "PostToolUse": [{ "matcher": "", "hooks": [{ "type": "command", "command": "~/.config/bin/codex-session-state working", "timeout": 10 }] }],
      "Stop": [{ "matcher": "", "hooks": [{ "type": "command", "command": "~/.config/bin/codex-session-state idle", "timeout": 10 }] }],
      "PreToolUse": []
    }
  }
  ```
  First launch of `codex` after editing this prompts a one-time "Hooks need review" trust dialog -- pick "Trust all and continue".

## Code Style

- **Lua**: 2-space indent, double quotes, stylua (column width 100)
- **Shell**: `#!/bin/bash`, descriptive variable names, fzf for interactive selections
- **Go**: goimports-reviser + golines + gofumpt; explicit error handling; json struct tags
- **YAML/TOML**: lowercase keys, 2-space indent
