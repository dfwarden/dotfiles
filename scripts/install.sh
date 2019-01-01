#!/bin/bash

# Taken from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#   https://github.com/ernstnaezer/dotfiles/blob/master/osx.sh
#   https://github.com/tiiiecherle/osx_install_config/blob/master/11_system_and_app_preferences/11c_osx_preferences_sierra.sh

# Default to show you everything the script is doing.
set -x

# Things to do in this dotfiles repo

# Get the base path of where this repo was cloned to and go there
REPO="$(cd "$(dirname "$(dirname "${BASH_SOURCE[0]}" )" )" >/dev/null && pwd)"
cd $REPO

# unlock git-crypt dotfiles, requires git-crypt and gnupg
git-crypt unlock

# in this repo, call a global git alias of ours to convert *.plist files to
# xml for diff purposes.
git config diff.plist.textconv 'git plutil-toxml1'

# submodules
git submodule update --init

# GNU Stow
STOW_PACKAGES_HOME=(git gnupg vim zsh)
STOW_PACKAGES_LOCALBIN=(bin)

for stow_package in "${STOW_PACKAGES_HOME[@]}"; do
  stow -t ${HOME} $stow_package
done
for stow_package in "${STOW_PACKAGES_LOCALBIN[@]}"; do
  stow -t /usr/local/bin $stow_package
done

# XDG stow known folders in xdg-configs
mkdir -p $HOME/.config
stow -t $HOME/.config xdg-configs

# ZSH themes and plugins
cp "zsh/themes/"*".zsh-theme" "${HOME}/.oh-my-zsh/custom/themes"
# I believe this has to be a clone and not a submodule since oh-my-zsh is a submodule
git clone https://github.com/zsh-users/zsh-completions "${HOME}/.oh-my-zsh/custom/plugins/zsh-completions"

# Install Vundle plugins from .vimrc
vim +PluginUpdate +qall

