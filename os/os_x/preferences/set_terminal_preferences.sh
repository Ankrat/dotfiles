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
    
    execute "defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true"
        "Tell iTerm2 to use the custom preferences in the directory"
    
    # execute "osascript set_custom_terminal_theme.scpt" \
    #     "Set custom terminal theme"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Terminal\n\n"
    set_preferences

}

main
