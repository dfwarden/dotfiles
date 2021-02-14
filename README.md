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

## Still Manual

* Sign-in to browsers, comms

### Mac

  * Better Touch Tool import preset
  * Downgrade Dash to 4
  * Karabiner kext approve
