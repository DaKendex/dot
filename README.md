# computer-setup
A repo for my computer setup

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
brew bundle --file macos/Brewfile

# Brew install 
brew bundle install --file macos/Brewfile
```

### Mac OS Tweaks
Dock Hides and Appears Instantly
```
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
```

### Install dadjoke
```
# dadjoke
cp /scripts/dadjoke/dadjoke /usr/local/bin/dadjoke
chmod +x /usr/local/bin/dadjoke
```