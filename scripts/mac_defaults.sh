# Default to show you everything the script is doing.
set -x

# global
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
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# keyboards
# Take USB Vendor and Product ID of known external keyboards and change their modifier keys.
# Better way would be to enumerate all HID keyboard and set this on all non-Apple keyboards.
# This has to be XML because otherwise defaults will try to write everything
# as strings. See: https://apple.stackexchange.com/questions/141069/updating-modifier-keys-from-the-command-line-takes-no-effect
PC_KEYBOARD_MODIFIERS="<array>
        <dict>
            <key>HIDKeyboardModifierMappingDst</key>
            <integer>0</integer>
            <key>HIDKeyboardModifierMappingSrc</key>
            <integer>30064771129</integer>
        </dict>
        <dict>
            <key>HIDKeyboardModifierMappingDst</key>
            <integer>30064771299</integer>
            <key>HIDKeyboardModifierMappingSrc</key>
            <integer>30064771298</integer>
        </dict>
        <dict>
            <key>HIDKeyboardModifierMappingDst</key>
            <integer>30064771303</integer>
            <key>HIDKeyboardModifierMappingSrc</key>
            <integer>30064771302</integer>
        </dict>
        <dict>
            <key>HIDKeyboardModifierMappingDst</key>
            <integer>30064771298</integer>
            <key>HIDKeyboardModifierMappingSrc</key>
            <integer>30064771299</integer>
        </dict>
        <dict>
            <key>HIDKeyboardModifierMappingDst</key>
            <integer>30064771302</integer>
            <key>HIDKeyboardModifierMappingSrc</key>
            <integer>30064771303</integer>
        </dict>
    </array>"  # capslock does nothing, swap command and alt.
# Also, bash will try to single quote everything separated by a space, so remove all spaces to make one big single quote block of XML.
PC_KEYBOARD_MODIFIERS_ONELINE="$(echo "${PC_KEYBOARD_MODIFIERS}" | tr -d '[:space:]')"
PC_KEYBOARD_IDS=("65261-24672") # sculpt mod
for keyboard in "${PC_KEYBOARD_IDS[@]}"
do
  # Bash will single quote $PC_KEYBOARD_MODIFIERS for us.
  defaults -currentHost write NSGlobalDomain com.apple.keyboard.modifiermapping.$keyboard-0 $PC_KEYBOARD_MODIFIERS_ONELINE
done

# dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false
defaults write com.apple.dock showhidden -bool true

# mission control
defaults write com.apple.dock mru-spaces -bool false

# clock
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
defaults write com.apple.menuextra.clock DateFormat "MMM d  H:mm"

# privacy
defaults write com.apple.lookup.shared LookupSuggestionsDisabled -bool true

# menubar
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true

# finder
FINDER_BOOL_TRUE=(ShowExternalHardDrivesOnDesktop AppleShowAllFiles AppleShowAllExtensions ShowStatusBar _FXShowPosixPathInTitle DSDontWriteNetworkStores QLEnableTextSelection)
for key in "${FINDER_BOOL_TRUE[@]}"; do
  defaults write com.apple.finder $key -bool true
done
FINDER_BOOL_FALSE=(SidebarTagsSctionDisclosedState ShowPathbar FXEnableExtensionChangeWarning)
for key in "${FINDER_BOOL_FALSE[@]}"; do
  defaults write com.apple.finder $key -bool false
done
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder NewWindowTargetPath "file://${HOME}"
# search current folder by default
defaults write com.apple.finder FXDefaultSearchScope SCcf
# column view
defaults write com.apple.finder FXPreferredViewStyle clmv
# desktop grid view
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# desktop item info
defaults write com.apple.finder showItemInfo -bool true
defaults write com.apple.finder textSize 13

# safari
SAFARI_BOOL_TRUE=(AlwaysShowTabBar AlwaysRestoreSessionAtLaunch ShowOverlayStatusBar ShowFullURLInSmartSearchField)
for key in "${SAFARI_BOOL_TRUE[@]}"; do
  defaults write com.apple.safari $key -bool true
done
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari ShowSidebarInTopSites -bool false
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
defaults write com.apple.Safari ProxiesInBookmarksBar "()"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
