#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_preferences() {

    execute "defaults write NSGlobalDomain AppleLanguages -array 'en'" \
        "Set language"

    execute "defaults write NSGlobalDomain AppleMeasurementUnits -string 'Centimeters' \
                && defaults write NSGlobalDomain AppleMetricUnits -bool true" \
        "Set measurement units"

    execute "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true" \
        "Enable auto-correct"
        
    
    execute "sudo systemsetup -settimezone 'Europe/London' &> /dev/null" \
        "Set the timezone"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Language & Region\n\n"
    set_preferences

}

main
