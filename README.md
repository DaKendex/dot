# dotfiles

Personal macOS development environment configuration using GNU Stow for dotfile management.

## Overview

This repository contains configurations for a terminal-centric development workflow including:

- **Shell**: Zsh with custom plugins and configurations
- **Editor**: Neovim with extensive plugin setup
- **Terminal**: Ghostty/WezTerm with tmux integration
- **Tools**: Git, fzf, ripgrep, lazygit, k9s, and more
- **Window Management**: AeroSpace + Borders
- **Custom Scripts**: Worktree management, GitHub shortcuts, MOTD

## Quick Start

```bash
# Clone repository
git clone <repo-url> ~/repo/dot && cd ~/repo/dot

# Run automated setup
./install.sh
```

The install script handles Homebrew installation, package installation via Brewfile, and dotfile symlinking with Stow.

## Manual Installation

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. Install Packages

```bash
brew bundle install --file=Brewfile
```

### 3. Symlink Dotfiles

```bash
stow .
```

## Custom Scripts

- `wta`: Git worktree automation with conventional branch naming
- `open-github`: Open current repository in GitHub from tmux
- `motd`: Display message of the day banner
- `dadjoke`: Fetch random dad jokes (Go implementation)

## macOS Tweaks

```bash
# Instant dock auto-hide
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -int 0
killall Dock

# Disable .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Enable window dragging with Ctrl+Cmd
defaults write -g NSWindowShouldDragOnGesture -bool true
```

## Repository Structure

```
.config/
├── nvim/          # Neovim configuration
├── tmux/          # Tmux configuration
├── zsh/           # Zsh shell configs and aliases
├── bin/           # Custom executable scripts
├── aerospace/     # Window manager config
├── ghostty/       # Terminal emulator config
└── ...            # Other tool configs

Brewfile           # Homebrew package definitions
install.sh         # Automated setup script
.stowrc            # Stow configuration
```

## Local Configuration Files

Several git-ignored files allow for machine-specific customization:

### `~/.env.zsh`
Sourced early in shell initialization for environment variables and secrets:
```bash
# ~/.env.zsh
export GITHUB_TOKEN="ghp_..."
export AWS_FEDERAL=true          # Enable FIPS endpoints
export CUSTOM_VAR="value"
alias work="cd ~/work-projects"
```

### `~/.sesh.toml`
Additional sesh sessions imported into the main config:
```toml
# ~/.sesh.toml
[[session]]
name = "Work Project"
path = "~/work/my-project"
startup_command = "nvim"
```

## Managing Dotfiles

```bash
# Update Brewfile with current packages
brew bundle dump --force --describe --file=Brewfile

# Re-stow after changes
stow -R .
```
