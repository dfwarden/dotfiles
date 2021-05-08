# New Machine?

## OS-Specific Prereqs

### Mac

1. Install [Homebrew](https://brew.sh)

## Then...

1. Get required programs from your package manager of choice:
  * `zsh` (if missing)
  * `git-crypt`
  * `stow`
  * `gnupg`
2. Set up SSH keys
  * $HOME/.ssh folder mode `0700`
  * `ssh-add identity-that-can-fetch-repo`
3. Set up GPG: `gpg --import` public, then private keys
4. `git clone` this repo

## Install
  * Run `scripts/install.sh`

### Mac
  * Run `scripts/install_mac.sh`
  * Logout and back in
  * Run `scripts/install_mac.sh` again

## Still Manual

* Sign-in to browsers, comms

### Mac

  * Better Touch Tool license
  * Karabiner kext approve
  * 1password Safari extension - enable
  * 1password Firefox/Chromeish extension - install
  * Finder sidebar show all hard drives in Locations
  * Microsoft Remote Desktop saves preferences/connections in sqlite at `/Users/${USER}/Library/Containers/com.microsoft.rdc.macos/Data/Library/Application Support/com.microsoft.rdc.macos`
    * It seems you can't symlink these to a location outside of ~/Library/Containers, which makes sense.

# Notes
  * [macOS Defaults](https://macos-defaults.com) - a handy site of known keys for the Defaults system.
