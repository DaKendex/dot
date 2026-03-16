#!/bin/bash

set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

# Helper functions
print_status() {
  echo -e "${BLUE}==>${NC} ${BOLD}$1${NC}"
}

print_success() {
  echo -e "${GREEN}✓${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1" >&2
}

print_warning() {
  echo -e "${YELLOW}!${NC} $1"
}

# Detect script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

echo ""
echo -e "${BOLD}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║          dotfiles Installation Script          ║${NC}"
echo -e "${BOLD}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Install Brew
print_status "Checking Homebrew installation..."
if ! type brew &>/dev/null; then
  print_warning "About to download and execute Homebrew installer from GitHub"
  print_warning "URL: https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
  echo "Press Enter to continue or Ctrl+C to cancel..."
  read -r
  
  print_status "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    print_error "Failed to install Homebrew"
    exit 1
  }
  
  # Setup brew shellenv for both Intel and Apple Silicon
  if [[ -x /opt/homebrew/bin/brew ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/usr/local/bin/brew shellenv)"
  else
    print_error "Homebrew binary not found after installation"
    exit 1
  fi
  
  print_success "Homebrew installed"
else
  print_success "Homebrew already installed"
  # Ensure shellenv is set for current session
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# Brew Packages
print_status "Installing Homebrew packages from Brewfile..."
if [[ ! -f "$BREWFILE" ]]; then
  print_error "Brewfile not found at: $BREWFILE"
  exit 1
fi

if [[ ! -r "$BREWFILE" ]]; then
  print_error "Brewfile is not readable: $BREWFILE"
  exit 1
fi

brew bundle install --file="$BREWFILE" --no-lock || {
  print_warning "Some packages failed to install, but continuing..."
}
print_success "Homebrew packages processed"

# Install Zap for zsh
print_status "Installing Zap plugin manager for zsh..."
if [[ ! -d "$HOME/.local/share/zap" ]]; then
  print_warning "About to download and execute Zap installer"
  print_warning "URL: https://raw.githubusercontent.com/zap-zsh/zap/release-v1/install.zsh"
  sleep 2
  
  zsh <(curl -fsSL https://raw.githubusercontent.com/zap-zsh/zap/release-v1/install.zsh) || {
    print_warning "Zap installation failed, but continuing..."
  }
  print_success "Zap installed"
else
  print_success "Zap already installed"
fi

# Mac OS Settings
echo ""
print_status "Applying macOS settings..."

###############################################################################
# Dock                                                                        #
###############################################################################
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.dock tilesize -int 37
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock "expose-group-apps" -bool true # Aerospace requirement
print_success "Dock settings applied"

###############################################################################
# Finder                                                                      #
###############################################################################
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Default to list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Disable creation of .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Disable creation of .DS_Store files on USB drives
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
print_success "Finder settings applied"

###############################################################################
# Trackpad & Mouse                                                            #
###############################################################################
# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Disable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
print_success "Trackpad & Mouse settings applied"

###############################################################################
# Keyboard                                                                    #
###############################################################################
# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
print_success "Keyboard settings applied"

###############################################################################
# Screenshots                                                                 #
###############################################################################
# Save screenshots to Downloads folder
defaults write com.apple.screencapture location -string "${HOME}/Downloads"
# Save screenshots as PNG
defaults write com.apple.screencapture type -string "png"
# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true
print_success "Screenshot settings applied"

###############################################################################
# System UI                                                                   #
###############################################################################
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# Show battery percentage in menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
print_success "System UI settings applied"

###############################################################################
# Apply Changes                                                               #
###############################################################################
print_status "Restarting Dock and Finder to apply changes..."
killall Dock
killall Finder
print_success "macOS settings applied"

# Link dotfiles
echo ""
print_status "Linking dotfiles with GNU Stow..."
cd "$SCRIPT_DIR"
if stow --restow --verbose=0 .; then
  print_success "Dotfiles linked successfully"
else
  print_error "Stow failed - there may be conflicting files in $HOME"
  print_warning "Run 'stow --verbose=2 .' in $SCRIPT_DIR to see conflicts"
  exit 1
fi

# brew auto update
print_status "Setting up Homebrew auto-update..."
if brew autoupdate start --upgrade &>/dev/null; then
  print_success "Homebrew auto-update enabled"
else
  print_warning "Homebrew auto-update setup failed, but continuing..."
fi

# Final summary
echo ""
echo -e "${GREEN}${BOLD}╔════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}${BOLD}║         Installation Complete! 🎉              ║${NC}"
echo -e "${GREEN}${BOLD}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}Summary:${NC}"
echo "  ✓ Homebrew and packages installed"
echo "  ✓ Zap plugin manager for zsh installed"
echo "  ✓ macOS settings configured"
echo "  ✓ Dotfiles symlinked to $HOME"
echo ""
echo -e "${BOLD}Next steps:${NC}"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. Verify setup: neovim, tmux, and zsh should work"
echo "  3. Configure machine-specific settings in ~/.env.zsh"
echo ""
