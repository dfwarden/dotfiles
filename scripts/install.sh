#!/bin/bash

# Taken from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#   https://github.com/ernstnaezer/dotfiles/blob/master/osx.sh
#   https://github.com/tiiiecherle/osx_install_config/blob/master/11_system_and_app_preferences/11c_osx_preferences_sierra.sh

# Default to show you everything the script is doing.
set -x

STOW_PACKAGES=(git vim zsh)

# Get the base path of where this repo was cloned to and go there
REPO="$(cd "$(dirname "$(dirname "${BASH_SOURCE[0]}" )" )" >/dev/null && pwd)"
cd $REPO

brew bundle

# unlock git-crypt dotfiles, requires git-crypt and gnupg
git-crypt unlock

for stow_package in "${STOW_PACKAGES[@]}"; do
  stow $stow_package
done

# make sure zsh is current shell
CURRENT_SHELL=$(dscl . -read /Users/${USER} UserShell | awk '{print $2}')
if [ "$CURRENT_SHELL" != "/bin/zsh" ]; then
    chsh -s $(which zsh) ${USER}
fi
cp "zsh/themes/"*".zsh-theme" "${HOME}/.oh-my-zsh/custom/themes"

# Install Vundle plugins from .vimrc
vim +PluginUpgrade +qall

# Better Touch Tool
BTT="${HOME}/Library/Application Support/BetterTouchTool"
mkdir -p $BTT
stow bettertouchtool -t $BTT
stow library-preferences -t $HOME/Library/Preferences

# Set up LoginItems
loginitems -a BetterTouchTool
loginitems -a MenuMetersApp -p "${HOME}/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuMetersApp.app"
loginitems -a 'Alfred 3'
loginitems -a Dash
loginitems -a Caffeine
