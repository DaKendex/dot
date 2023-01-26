#!/bin/bash

homedir=$HOME

# dotfiles directory
dotfiledir=${homedir}/repo/computer-setup/dotfiles

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Brew Packages
brew bundle install --file ~/repo/computer-setup/macos/Brewfile

# Mac OS
defaults write com.apple.dock autohide-delay -float 0; killall Dock

# Yabai
sudo yabai --install-sa
sudo yabai --load-sa
brew services start skhd
brew services start yabai

# zshrc and dotfiles
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install zsh

ln -sf ${dotfiledir}/yabai/yabairc ${homedir}/.config/yabai/yabairc
ln -sf ${dotfiledir}/skhd/skhdrc ${homedir}/.config/skhd/skhdrc
ln -sf ${dotfiledir}/karabiner/karabiner.json ${homedir}/.config/karabiner/karabiner.json
ln -sf ${dotfiledir}/.zshrc ${homedir}/.zshrc
ln -sf ${dotfiledir}/.vimrc ${homedir}/.vimrc
ln -sf ${dotfiledir}/starship/starhip.toml ${homedir}/.config/starship.toml

source ~/.zshrc

# brew auto update
brew autoupdate start --upgrade

# dadjoke
cp dadjoke.py ~/usr/local/bin/dadjoke
chmod +x ~/usr/local/bin/dadjoke
