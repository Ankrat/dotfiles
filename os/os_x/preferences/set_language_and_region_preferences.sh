#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write NSGlobalDomain AppleLanguages -array 'en'" \
        "Set language"

    execute "defaults write NSGlobalDomain AppleMeasurementUnits -string 'Centimeters'" \
        "Set measurement units"

    execute "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true" \
        "Enable auto-correct"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Language & Region\n\n"
    set_preferences

}

main
