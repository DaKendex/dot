# computer-setup
A repo for my computer setup

## Install with install.sh


## Install Brew files
```
brew bundle --file macos/Brewfile
```


## Mac OS Tweaks
- Dock Hides and Appears Instantly
```
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
```
