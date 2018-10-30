#!/bin/bash

# Default to show you everything the script is doing.
set -x

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

dockutil --add '/Applications/Messages.app/' --position 'beginning'
dockutil --add '/Applications/Slack.app/' --after 'Messages'
dockutil --add '/Applications/Twitterrific.app/' --before 'Safari'
dockutil --add '/Applications/Firefox.app/' --after 'Safari'
dockutil --add '/Applications/Google Chrome.app/' --after 'Safari'
dockutil --add '/Applications/iTerm.app/' --after 'Firefox'
dockutil --add '/Applications/1Password 7.app/' --before 'iTunes'
