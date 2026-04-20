# Agent Guidelines for dotfiles Repository

## Overview
This is a macOS dotfiles repository managed with GNU Stow. Configuration files for Neovim, Zsh, Tmux, and various CLI tools.

## Build/Test Commands
- **Go tests**: `cd .config/bin/dadjoke-go && go test -v` (run all tests)
- **Go single test**: `cd .config/bin/dadjoke-go && go test -v -run TestDadJokeAPI`
- **Go build**: `cd .config/bin/dadjoke-go && make build`
- **PlantUML**: `cd desksetup && make generate`
- **Stow dotfiles**: `stow .` (from repo root)
- **Brew sync**: `brew bundle --file=Brewfile`

## Code Style

### Lua (Neovim configs)
- 2 spaces indentation, no tabs
- Format with stylua (column width: 100)
- Use double quotes for strings
- Local variables preferred: `local map = function(...)`
- Descriptive keymap helpers: `map("<leader>ff", builtin.find_files, "Find files")`

### Go
- Format with: goimports-reviser, golines, gofumpt
- Explicit error handling with log.Fatalln() or log.Fatal()
- Use json tags for structs: `json:"field_name"`
- Standard library imports first, blank line, then third-party

### Shell Scripts
- Bash scripts with `#!/bin/bash` shebang
- Color codes for output: GREEN, RED, YELLOW, BLUE, BOLD, NC
- Use fzf for interactive selections
- Descriptive variable names: `repo_root`, `current_dir`

### Configuration Files
- YAML/TOML: lowercase keys, 2-space indent
- Comments explain non-obvious settings
- Use relative paths where possible

## Naming Conventions
- Lua plugins: kebab-case filenames matching plugin name
- Shell scripts: lowercase, no extension for executables
- Config directories: lowercase application name
- Git branches: conventional format (feature/, bugfix/, hotfix/, release/, chore/)

## Branch Strategy

This repo uses a two-branch model to separate personal (public) config from work-specific config:

- `main` — pushed to GitHub, personal configs only
- `work` — local only, rebased on `main`, holds work-specific commits on top

### Commit conventions
- Prefix work-specific commits with `work:` (e.g. `work: aws profiles`, `work: gh-dash work repos`)
- Personal commits use standard conventional format and are safe to cherry-pick to `main`

### Syncing personal changes to main
```bash
# Cherry-pick all non-work commits from work branch to main
git checkout main
git cherry-pick $(git log main..work --invert-grep --grep="^work:" --format="%H" | tac)
git push
git checkout work
git rebase main
```

### Pulling upstream changes into work
```bash
git fetch origin
git rebase origin/main   # while on work branch
```

### Guards
- `branch.work.rebase=true` — pull always rebases, no merge commits
- `branch.work.pushremote=no_push` — blocks `git push` with no arguments
- `.git/hooks/pre-push` — blocks `git push origin` and any explicit remote push from `work`; installed automatically by `install.sh` when machine profile is set to `work`

### Staging mixed files
Use `git add -p` (or lazygit/neogit hunk staging) to split personal and work changes in the same file before committing.
