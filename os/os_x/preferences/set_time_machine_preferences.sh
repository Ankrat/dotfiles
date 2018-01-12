#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true" \
        "Prevent Time Machine from prompting to use new hard drives as backup volume"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Time Machine\n\n"
    set_preferences

    killall "Time Machine" &> /dev/null

}

main
