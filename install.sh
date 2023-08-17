#!/bin/bash

homedir=$HOME

# dotfiles directory
dotfiledir=${homedir}/repo/computer-setup/dotfiles

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Brew Packages
brew bundle install --file ~/repo/computer-setup/Brewfile

# Install Zap for zsh
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

# Mac OS
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock


# Link dotfiles
stow -t $HOME zsh
stow -t $HOME yabai
stow -t $HOME skhd
stow -t $HOME karabiner
stow -t $HOME starship
ln -sf ${dotfiledir}/scripts/motd/motd.sh ${homedir}/.config/motd.sh

source ~/.zshrc

# brew auto update
brew autoupdate start --upgrade

# dadjoke
cp /scripts/dadjoke/dadjoke /usr/local/bin/dadjoke
chmod +x /usr/local/bin/dadjoke

# Yabai
sudo yabai --install-sa
sudo yabai --load-sa
brew services start skhd
brew services start yabai
