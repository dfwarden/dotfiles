# New Machine?

## OS-Specific Prereqs

### Mac

1. Install [Homebrew](https://brew.sh)
2. Install [Dockutil](https://github.com/kcrawford/dockutil/releases)

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

#### Time Machine Restore Tasks
  * Manually add the Time Machine destination with `sudo tmutil setdestination -p smb://{user}@{host}/{TM share}`
  * List the available backups and their mount paths with `sudo tmutil listbackups -m`

##### Music / iTunes
This is fragile because I use SMB-based Time Machine.
  * Browse the latest backup mount point, restore Music with `sudo tmutil restore -v {ugly path}/Music /Users/warden/Music`

##### Microsoft Remote Desktop
  * Microsoft Remote Desktop saves preferences/connections in sqlite at `/Users/${USER}/Library/Containers/Microsoft Remote Desktop/Data/Library/Application Support/com.microsoft.rdc.macos`
  * Install and run the App Store version of Remote Desktop Client
  * Restore your RDC sqlite files with `sudo tmutil restore -v {ugly path}/Users/warden/Library/Containers/Microsoft Remote Desktop/Data/Library/Application\ Support/com.microsoft.rdc.macos {somewhere}`
  * Copy those files to `Library/Containers/Microsoft Remote Desktop/Data/Library/Application Support/com.microsoft.rdc.macos` (should have good perms after this)

## Still Manual

* Sign-in to browsers, comms, nextcloud

### Mac

  * Safari Status Bar
    * com.apple.Safari ShowOverlayStatusBar=1 is not enough
    * only other difference before/after in com.apple.Safari is adding ShowDownloadsToolbarIdentifier to "TB Default Item Identifiers" array in "NSToolbar Configuration BrowserStandaloneTabBarToolbarIdentifier" dict.
    * com.apple.Safari.plist and other goodies are in ~/Library/Containers/com.apple.Safari/Data/Library/Preferences, but no luck finding anything related to Status Bar
  * Karabiner kext approve
  * 1password Safari extension - enable
  * 1password Firefox/Chromeish extension - install
  * Finder sidebar show all hard drives in Locations
  * Bitwarden sign-in, settings
  * Mac wallpaper
  * Teams wallpaper, settings

# Notes
  * [macOS Defaults](https://macos-defaults.com) - a handy site of known keys for the Defaults system.
