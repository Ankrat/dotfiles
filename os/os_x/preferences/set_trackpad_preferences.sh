#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true \
                && defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 \
                && defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1" \
        "Enable 'Tap to click'"

    execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2 \
                && defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true \
                && defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1 \
                && defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true "\
        "Map bottom right corner to right-click"

    execute "defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false" \
        "Disable “natural” (Lion-style) scrolling"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Trackpad\n\n"
    set_preferences

}

main
