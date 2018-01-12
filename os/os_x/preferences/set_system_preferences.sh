#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "sudo defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true" \
        "Prevent Time Machine from prompting to use new hard drives as backup volume"

    ###############################################################################
    # SSD-specific tweaks                                                         #
    ###############################################################################

    execute "sudo pmset -a hibernatemode 0" \
        "Disable hibernation (speeds up entering sleep mode)"

    execute "sudo rm /private/var/vm/sleepimage" \
        "Remove the sleep image file to save disk space"

    execute "sudo touch /private/var/vm/sleepimage" \
        "Create a zero-byte file instead..."

    execute "sudo chflags uchg /private/var/vm/sleepimage" \
        "...and make sure it can’t be rewritten"

    execute "sudo pmset -a sms 0" \
        "Disable the sudden motion sensor as it’s not useful for SSDs"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Time Machine\n\n"
    set_preferences

    killall "Time Machine" &> /dev/null

}

main