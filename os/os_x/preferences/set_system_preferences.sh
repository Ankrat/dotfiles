#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {
        
    execute "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true" \
        "Prevent Time Machine from prompting to use new hard drives as backup volume"

    execute "defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool no" \
        "Disable power button from putting your mac in Stand-by mode"

    ###############################################################################
    # SSD-specific tweaks                                                         #
    ###############################################################################

    execute "sudo pmset -a hibernatemode 0" \
        "Disable hibernation (speeds up entering sleep mode)"


    execute "sudo pmset -a sms 0" \
        "Disable the sudden motion sensor as it’s not useful for SSDs"

    ###############################################################################
    # NOT PERMITTED
    ###############################################################################
    # execute "rm /private/var/vm/sleepimage" \
    #     "Remove the sleep image file to save disk space"

    # execute "touch /private/var/vm/sleepimage" \
    #     "Create a zero-byte file instead..."

    # execute "chflags uchg /private/var/vm/sleepimage" \
    #     "...and make sure it can’t be rewritten"


}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Time Machine\n\n"
    set_preferences

    killall "Time Machine" &> /dev/null

}

main
