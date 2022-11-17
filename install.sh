#!/bin/bash

cd $HOME

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Brew Packages
brew bundle install --file ~/computer-setup/macos/Brewfile

# Mac OS
defaults write com.apple.dock autohide-delay -float 0
killall Dock

# Yabai
sudo yabai --install-sa
sudo yabai --load-sa
brew services start skhd
brew services start yabai

# zshrc and dotfiles
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install zsh
cp ~/repo/computer-setup/dotfiles/skhd/skhdrc ~/.config/skhd
cp ~/repo/computer-setup/dotfiles/yabai/yabairc ~/.config/yabai
cp ~/repo/computer-setup/dotfiles/karabiner/karabiner.json ~/.config/karabiner/
cp ~/repo/computer-setup/dotfiles/.zshrc ~/
cp ~/repo/computer-setup/dotfiles/.vimrc ~/
source ~/.zshrc

# brew auto update
brew autoupdate start --upgrade

# dadjoke
cp dadjoke.py ~/usr/local/bin/dadjoke
chmod +x ~/usr/local/bin/dadjoke
