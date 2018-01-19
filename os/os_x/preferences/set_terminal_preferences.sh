#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

declare iTermPreferencesDirectory="$HOME/.dotfiles/os/os_x/preferences"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write com.apple.terminal FocusFollowsMouse -string true" \
        "Make the focus automatically follow the mouse"

    execute "defaults write com.apple.terminal StringEncodings -array 4" \
        "Only use UTF-8"

    execute "defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string $iTermPreferencesDirectory" \
        "Specify the preferences directory"
    
    execute "defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true" \
        "Tell iTerm2 to use the custom preferences in the directory"

    execute "defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'" \
        "Add iTerm2 to Dock"


    print_info "Import cobalt2 preset colors"
    
    /usr/libexec/PlistBuddy -c "Add 'Custom Color Presets':'cobalt2' dict" ~/Library/Preferences/com.googlecode.iTerm2.plist
    /usr/libexec/PlistBuddy -c "Merge '$(pwd)/cobalt2.itermcolors' 'Custom Color Presets':'cobalt2'" ~/Library/Preferences/com.googlecode.iTerm2.plist

    
    # execute "osascript set_custom_terminal_theme.scpt" \
    #     "Set custom terminal theme"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Terminal\n\n"
    set_preferences

}

main
