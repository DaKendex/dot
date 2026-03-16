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

### Fresh macOS Installation (One-Line)

Run this single command on a fresh Mac to install everything:

```bash
curl -fsSL https://raw.githubusercontent.com/DaKendex/dot/main/bootstrap.sh | bash
```

The bootstrap script will:
- Install Xcode Command Line Tools (if needed)
- Clone this repository to `~/repo/dot` (or custom location)
- Run the main installation script automatically
- Install Homebrew and all packages
- Configure macOS settings
- Symlink dotfiles with GNU Stow

### Alternative: Install Homebrew First (Recommended)

If you encounter issues with Command Line Tools installation, or prefer a more reliable approach:

**Step 1:** Install Homebrew (includes git and other tools):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Step 2:** Run bootstrap with skip flag:
```bash
curl -fsSL https://raw.githubusercontent.com/DaKendex/dot/main/bootstrap.sh | bash -s -- --skip-xcode-check
```

This method is often more reliable on fresh Macs since Homebrew handles all the necessary dependencies.

### Manual Installation

If you prefer to clone manually:

```bash
# Clone repository
git clone https://github.com/DaKendex/dot.git ~/repo/dot
cd ~/repo/dot

# Run automated setup
./install.sh
```

## Step-by-Step Manual Installation

If you prefer full control over each step:

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. Clone Repository

```bash
git clone https://github.com/DaKendex/dot.git ~/repo/dot
cd ~/repo/dot
```

### 3. Install Packages

```bash
brew bundle install --file=Brewfile
```

### 4. Symlink Dotfiles

```bash
stow .
```

## Custom Scripts

- `wta`: Git worktree automation with conventional branch naming
- `open-github`: Open current repository in GitHub from tmux
- `motd`: Display message of the day banner
- `dadjoke`: Fetch random dad jokes (Go implementation)

## macOS Tweaks

The install script configures various macOS settings. You can also apply individual tweaks:

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
bootstrap.sh       # Bootstrap script for fresh installs
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

## Troubleshooting

### Command Line Tools Installation Fails

If the automated Command Line Tools installation doesn't work:

1. **Option A:** Install Homebrew first (recommended)
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   # Then run bootstrap with: --skip-xcode-check flag
   ```

2. **Option B:** Install Command Line Tools manually
   ```bash
   xcode-select --install
   # Wait for popup, click Install, then re-run bootstrap
   ```

### Stow Conflicts

If stow reports conflicts with existing files:

```bash
cd ~/repo/dot
stow --verbose=2 .  # See detailed conflict list
# Backup conflicting files, then re-run stow
```

### Brew Package Failures

The install script continues even if individual packages fail. To retry failed packages:

```bash
cd ~/repo/dot
brew bundle install --file=Brewfile
```
