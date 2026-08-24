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

- **`ai-session-manager` (tmux `prefix+C` / Ghostty `Cmd+i`)**: picks between running Claude/Codex/Copilot sessions across tmux, with live status. Claude side needs nothing (reads `claude agents --json` directly). Codex and Copilot side each need a hooks file wired to their `*-session-state` script -- both files are real files outside the stow tree (like `.aws/config`), so a fresh machine needs them created by hand.

  `~/.codex/hooks.json` -- deliberately does *not* wire `PostToolUse`: it fires once per tool call, and on a multi-tool turn its writes can complete after `Stop`'s (hooks aren't guaranteed to run in firing order), leaving the pane stuck on `working` forever. `UserPromptSubmit` already covers "busy for the whole turn," so there's nothing `PostToolUse` adds:
  ```json
  {
    "hooks": {
      "SessionStart": [{ "matcher": "", "hooks": [{ "type": "command", "command": "~/.config/bin/codex-session-state idle", "timeout": 10 }] }],
      "UserPromptSubmit": [{ "matcher": "", "hooks": [{ "type": "command", "command": "~/.config/bin/codex-session-state working", "timeout": 10 }] }],
      "Stop": [{ "matcher": "", "hooks": [{ "type": "command", "command": "~/.config/bin/codex-session-state idle", "timeout": 10 }] }],
      "PostToolUse": [],
      "PreToolUse": []
    }
  }
  ```
  First launch of `codex` after editing this prompts a one-time "Hooks need review" trust dialog -- pick "Trust all and continue".

  `~/.copilot/hooks/hooks.json` (note the different field name -- `bash`, not `command`; same reason for skipping `postToolUse`, confirmed live 2026-08-24 -- a real multi-tool-call turn left the pane stuck on `working` until `postToolUse` was removed):
  ```json
  {
    "hooks": {
      "sessionStart": [{ "type": "command", "bash": "~/.config/bin/copilot-session-state idle", "timeoutSec": 10 }],
      "userPromptSubmitted": [{ "type": "command", "bash": "~/.config/bin/copilot-session-state working", "timeoutSec": 10 }],
      "sessionEnd": [{ "type": "command", "bash": "~/.config/bin/copilot-session-state idle", "timeoutSec": 10 }],
      "postToolUse": [],
      "preToolUse": []
    },
    "version": 1
  }
  ```
  No separate hooks-trust dialog observed for copilot -- just the normal one-time folder-trust prompt.

## Code Style

- **Lua**: 2-space indent, double quotes, stylua (column width 100)
- **Shell**: `#!/bin/bash`, descriptive variable names, fzf for interactive selections
- **Go**: goimports-reviser + golines + gofumpt; explicit error handling; json struct tags
- **YAML/TOML**: lowercase keys, 2-space indent
