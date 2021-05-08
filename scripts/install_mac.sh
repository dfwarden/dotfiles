#!/bin/bash

# Default to show you everything the script is doing.
set -x

# Better Touch Tool
LAS="${HOME}/Library/Application Support"
BTT="${LAS}/BetterTouchTool"
DASH="${LAS}/Dash"
mkdir -p $BTT $DASH/License
stow -t $LAS application-support

# Stow ~/Library/Preferences
stow -t $HOME/Library/Preferences library-preferences

brew bundle

# make sure zsh is current shell
CURRENT_SHELL=$(dscl . -read /Users/${USER} UserShell | awk '{print $2}')
if [ "$CURRENT_SHELL" != "/bin/zsh" ]; then
    chsh -s $(which zsh) ${USER}
fi

# Set up LoginItems
loginitems -a BetterTouchTool
loginitems -a MenuMetersApp -p "${HOME}/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuMetersApp.app"
loginitems -a 'Alfred 4'
loginitems -a Dash
loginitems -a KeepingYouAwake
loginitems -a nextcloud
loginitems -a Karabiner-Elements

# Locate command database
launchctl list com.apple.locate || sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# Finder sidebar management
mysides remove all
mysides add Applications file:///Applications
mysides add Home file://${HOME}
mysides add Downloads file://${HOME}/Downloads
mysides add Documents file://${HOME}/Documents

# Dock management

# remove garbage
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
dockutil --remove 'TV'
dockutil --remove 'Podcasts'

# add used apps
dockutil --add '/Applications/Twitterrific.app/'
dockutil --add '/Applications/Slack.app/'
dockutil --add '/Applications/Messages.app/'
dockutil --add '/Applications/Firefox.app/'
dockutil --add '/Applications/Microsoft Edge.app/'
dockutil --add '/Applications/Google Chrome.app/'
dockutil --add '/Applications/iTerm.app/'
dockutil --add '/Applications/1Password 7.app/'

# move used apps to desired locations
dockutil --move 'Twitterrific' --position 'beginning'
dockutil --move 'Slack' --after 'Twitterrific'
dockutil --move 'Messages' --after 'Slack'
dockutil --move 'Safari' --after 'Messages'
dockutil --move 'Firefox' --after 'Safari'
dockutil --move 'Microsoft Edge' --after 'Firefox'
dockutil --move 'Google Chrome' --after 'Microsoft Edge'
dockutil --move 'iTerm' --after 'Google Chrome'
dockutil --move '1Password 7' --after 'iTerm'

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

# Global Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

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

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleAquaColorVariant -int 1

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

# Scroll bars should be visible and position-jumpable
defaults write NSGlobalDomain AppleScrollerPagingBehavior -int 1
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Set correct scroll direction for mice wheels
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Messages.app
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict \
    automaticDashSubstitutionEnabled -bool false \
    automaticDataDetectionEnabled -bool false \
    automaticEmojiSubstitutionEnabledLegacy -bool false \
    automaticEmojiSubstitutionEnablediMessage -bool false \
    automaticLinkDetectionEnabled -bool false \
    automaticQuoteSubstitutionEnabled -bool false \
    automaticSpellingCorrectionEnabled -bool false \
    automaticTextReplacementEnabled -bool true \
    continuousSpellCheckingEnabled -bool true \
    grammarCheckingEnabled -bool false \
    smartInsertDeleteEnabled -bool true

# Dock & Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock show-recents -bool false
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
FINDER_BOOL_TRUE=(ShowHardDrivesOnDesktop ShowExternalHardDrivesOnDesktop ShowMountedServersOnDesktop ShowPathbar ShowStatusBar ShowPathbar _FXShowPosixPathInTitle _FXSortFoldersFirst DSDontWriteNetworkStores QLEnableTextSelection)
for key in "${FINDER_BOOL_TRUE[@]}"; do
  defaults write com.apple.finder $key -bool true
done
FINDER_BOOL_FALSE=(SidebarTagsSctionDisclosedState ShowRecentTags FXEnableExtensionChangeWarning AppleShowAllFiles)
for key in "${FINDER_BOOL_FALSE[@]}"; do
  defaults write com.apple.finder $key -bool false
done

# New window defaults to your $HOME
defaults write com.apple.finder NewWindowTarget 'PfHm'

# search current folder by default
defaults write com.apple.finder FXDefaultSearchScope SCcf

# column view
defaults write com.apple.finder FXPreferredViewStyle clmv

# Not sure what the next 2 do
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Finder toolbar should have text and icons
/usr/libexec/PlistBuddy -c "Set :'NSToolbar Configuration Browser':'TB Display Mode' 1" ~/Library/Preferences/com.apple.finder.plist

# finder desktop
# desktop grid view
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# desktop item info
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

killall -v Finder

# Safari
SAFARI_BOOL_TRUE=(AlwaysShowTabBar AlwaysRestoreSessionAtLaunch ShowOverlayStatusBar ShowFullURLInSmartSearchField IncludeDevelopMenu ShowIconsInTabs SuppressSearchSuggestions)
for key in "${SAFARI_BOOL_TRUE[@]}"; do
  defaults write com.apple.Safari $key -bool true
done
SAFARI_BOOL_FALSE=(UniversalSearchEnabled ShowFavoritesBar ShowSidebarInTopSites AutoFillPasswords AutoFillMiscellaneousForms AutoFillCreditCardData FindOnPageMatchesWordStartsOnly)
for key in "${SAFARI_BOOL_FALSE[@]}"; do
  defaults write com.apple.Safari $key -bool false
done
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Twitter
defaults write com.iconfactory.Twitterrific5 generalTheme -int 1
defaults write com.iconfactory.Twitterrific5 generalTrendsType -int 0
defaults write com.iconfactory.Twitterrific5 readingPositionService -int 1

killall -v cfprefsd
