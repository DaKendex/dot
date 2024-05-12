# dotfiles
A repo for my dotfiles

## Install with install.sh

### Install Homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

```
### Brew files
```
# Brew Bundle
brew bundle Brewfile

# Brew install 
brew bundle install Brewfile
```

### Stow 
```
# Install dotfiles
stow -t $HOME <folder>
```

### Mac OS Tweaks
```
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
```
#### Disable creation of .DS_Store files on network volumes
```
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
```

### Install dadjoke
```
# dadjoke
cp /.config/bin/dadjoke/dadjoke /usr/local/bin/dadjoke
chmod +x /usr/local/bin/dadjoke
```
