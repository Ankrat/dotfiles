#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write org.mozilla.firefox AppleEnableSwipeNavigateWithScrolls -bool true" \
        "Enable backswipe"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Firefox\n\n"
    set_preferences

    killall "firefox" &> /dev/null

}

main
