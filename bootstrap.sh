#!/bin/bash

set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

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

# Default installation directory
DEFAULT_INSTALL_DIR="$HOME/repo/dot"

echo ""
echo -e "${BOLD}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║     dotfiles Bootstrap Installation Script    ║${NC}"
echo -e "${BOLD}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Check for Command Line Tools
print_status "Checking for Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  print_warning "Command Line Tools not found"
  print_status "Installing Xcode Command Line Tools (this may take a few minutes)..."
  
  # Trigger installation
  xcode-select --install &>/dev/null || true
  
  # Wait for installation to complete
  echo "Please complete the Command Line Tools installation in the popup window."
  echo "Press Enter once the installation is complete..."
  read -r
  
  # Verify installation
  if ! xcode-select -p &>/dev/null; then
    print_error "Command Line Tools installation failed or was cancelled"
    exit 1
  fi
fi
print_success "Command Line Tools installed"

# Prompt for installation directory
echo ""
print_status "Choose installation directory"
echo -e "  Default: ${BOLD}${DEFAULT_INSTALL_DIR}${NC}"
read -rp "  Press Enter for default, or type custom path: " INSTALL_DIR
INSTALL_DIR="${INSTALL_DIR:-$DEFAULT_INSTALL_DIR}"

# Expand tilde to home directory
INSTALL_DIR="${INSTALL_DIR/#\~/$HOME}"

# Validate path security
if [[ "$INSTALL_DIR" =~ \.\. ]]; then
  print_error "Path contains '..' which could be dangerous"
  exit 1
fi

if [[ "${INSTALL_DIR:0:1}" != "/" ]]; then
  print_error "Path must be absolute (start with /)"
  exit 1
fi

# Prevent installation to dangerous system paths
case "$INSTALL_DIR" in
  /bin/*|/sbin/*|/usr/bin/*|/usr/sbin/*|/System/*)
    print_error "Cannot install to system directory: $INSTALL_DIR"
    exit 1
    ;;
esac

# Create parent directory if needed
PARENT_DIR=$(dirname "$INSTALL_DIR")
if [[ ! -d "$PARENT_DIR" ]]; then
  print_status "Creating parent directory: $PARENT_DIR"
  mkdir -p "$PARENT_DIR"
fi

# Check if directory already exists
if [[ -d "$INSTALL_DIR" ]]; then
  print_warning "Directory already exists: $INSTALL_DIR"
  
  # Check if it's a git repo
  if [[ -d "$INSTALL_DIR/.git" ]]; then
    print_warning "Existing git repository found"
    read -rp "  Update existing repository? (y/N): " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      print_status "Updating repository..."
      cd "$INSTALL_DIR"
      git pull origin main || git pull origin master || {
        print_error "Failed to update repository"
        exit 1
      }
      print_success "Repository updated"
    else
      print_status "Using existing repository"
    fi
  else
    print_error "Directory exists but is not a git repository"
    echo "  Please remove or rename: $INSTALL_DIR"
    exit 1
  fi
else
  # Clone repository
  print_status "Cloning dotfiles repository..."
  git clone https://github.com/DaKendex/dot.git "$INSTALL_DIR" || {
    print_error "Failed to clone repository"
    exit 1
  }
  print_success "Repository cloned"
fi

# Run main installation script
echo ""
print_status "Running main installation script..."
echo ""

cd "$INSTALL_DIR"

# Verify install.sh exists and make executable
if [[ ! -f install.sh ]]; then
  print_error "install.sh not found in $INSTALL_DIR"
  exit 1
fi

chmod +x install.sh

if [[ ! -x install.sh ]]; then
  print_error "Failed to make install.sh executable"
  exit 1
fi

./install.sh

echo ""
echo -e "${GREEN}${BOLD}╔════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}${BOLD}║           Bootstrap Complete! 🎉               ║${NC}"
echo -e "${GREEN}${BOLD}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}Next steps:${NC}"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. Configure 1Password and SSH keys"
echo "  3. Switch git remote to SSH (optional):"
echo "     cd $INSTALL_DIR"
echo "     git remote set-url origin git@github.com:DaKendex/dot.git"
echo ""
