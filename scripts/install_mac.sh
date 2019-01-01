#!/bin/bash

# Default to show you everything the script is doing.
set -x

brew bundle

# make sure zsh is current shell
CURRENT_SHELL=$(dscl . -read /Users/${USER} UserShell | awk '{print $2}')
if [ "$CURRENT_SHELL" != "/bin/zsh" ]; then
    chsh -s $(which zsh) ${USER}
fi

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

# Dock management
dockutil --remove 'Siri'
dockutil --remove 'Launchpad'
dockutil --remove 'Mail'
dockutil --remove 'Reminders'
dockutil --remove 'Maps'
dockutil --remove 'Photos'
dockutil --remove 'FaceTime'
dockutil --remove 'Pages'
dockutil --remove 'Numbers'
dockutil --remove 'Keynote'
dockutil --remove 'News'

dockutil --add '/Applications/Twitterrific.app/' --position 'beginning'
dockutil --add '/Applications/Slack.app/' --after 'Twitterrific'
dockutil --add '/Applications/Messages.app/' --after 'Slack'
dockutil --add '/Applications/Firefox.app/' --after 'Safari'
dockutil --add '/Applications/Google Chrome.app/' --after 'Safari'
dockutil --add '/Applications/iTerm.app/' --after 'Firefox'
dockutil --add '/Applications/1Password 7.app/' --before 'iTunes'

# Defaults System Changes

# Default to Google for web search
PROVIDER_WEB_SEARCH_GOOGLE=$(cat <<-END
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>NSPreferredWebServices</key>
	<dict>
		<key>NSWebServicesProviderWebSearch</key>
		<dict>
			<key>NSDefaultDisplayName</key>
			<string>Googlea</string>
			<key>NSProviderIdentifier</key>
			<string>com.google.www</string>
		</dict>
	</dict>
</dict>
</plist>
END
)
echo $PROVIDER_WEB_SEARCH_GOOGLE | defaults import -g -

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Keyboard control access
defaults write NSGlobalDomain AppleKeyboardUIMode 3

# Keyboard repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

# Always open new in tab
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"

# Pink accent
defaults write NSGlobalDomain AppleAccentColor -int 6
defaults write NSGlobalDomain AppleHighlightColor -string "1.000000 0.749020 0.823529 Pink"

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

defaults write com.apple.menuextra.clock DateFormat -string "MM dd HH:mm"

GLOBAL_BOOL_FALSE=(NSAutomaticTextCompletionEnabled NSAutomaticCapitalizationEnabled NSAutomaticTextCompletionEnabled NSAutomaticPeriodSubstitutionEnabled NSAutomaticSpellingCorrectionEnabled NSAutomaticQuoteSubstitutionEnabled NSAutomaticDashSubstitutionEnabled ApplePressAndHoldEnabled)
for key in "${GLOBAL_BOOL_FALSE[@]}"
do
  defaults write NSGlobalDomain $key -bool false
done

# Set correct scroll direction for mice wheels
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Dock & Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock.mineffect -string "scale"

# mission control
defaults write com.apple.dock mru-spaces -bool false

# clock
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
defaults write com.apple.menuextra.clock DateFormat "MMM d  H:mm"

# privacy
defaults write com.apple.lookup.shared LookupSuggestionsDisabled -bool true

# TextEdit
# Default to plain text
defaults write com.apple.TextEdit RichText -bool false

# finder
FINDER_BOOL_TRUE=(ShowHardDrivesOnDesktop ShowExternalHardDrivesOnDesktop ShowMountedServersOnDesktop ShowPathbar ShowStatusBar AppleShowAllExtensions _FXShowPosixPathInTitle DSDontWriteNetworkStores QLEnableTextSelection)
for key in "${FINDER_BOOL_TRUE[@]}"; do
  defaults write com.apple.finder $key -bool true
done
FINDER_BOOL_FALSE=(SidebarTagsSctionDisclosedState ShowPathbar FXEnableExtensionChangeWarning AppleShowAllFiles)
for key in "${FINDER_BOOL_FALSE[@]}"; do
  defaults write com.apple.finder $key -bool false
done

# New window defaults to $HOME
defaults write com.apple.finder NewWindowTargetPath "file://${HOME}"

# search current folder by default
defaults write com.apple.finder FXDefaultSearchScope SCcf

# column view
defaults write com.apple.finder FXPreferredViewStyle clmv

# Not sure what the next 2 do
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# finder desktop
# desktop grid view
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# desktop item info
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

killall Finder

# Safari
SAFARI_BOOL_TRUE=(AlwaysShowTabBar AlwaysRestoreSessionAtLaunch ShowOverlayStatusBar ShowFullURLInSmartSearchField IncludeDevelopMenu ShowIconsInTabs SuppressSearchSuggestions)
for key in "${SAFARI_BOOL_TRUE[@]}"; do
  defaults write com.apple.Safari $key -bool true
done
SAFARI_BOOL_FALSE=(UniversalSearchEnabled ShowFavoritesBar ShowSidebarInTopSites FindOnPageMatchesWordStartsOnly)
for key in "${SAFARI_BOOL_FALSE[@]}"; do
  defaults write com.apple.Safari $key -bool false
done
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Twitter
defaults write com.iconfactory.Twitterrific5 generalTheme -int 1
defaults write com.iconfactory.Twitterrific5 generalTrendsType -int 0
defaults write com.iconfactory.Twitterrific5 readingPositionService -int 1
