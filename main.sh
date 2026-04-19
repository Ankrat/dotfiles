#!/bin/bash

declare scriptDir=""
scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" \
    || { printf "Failed to resolve script directory.\n"; exit 1; }

cd "$scriptDir" \
    || { printf "Failed to change to script directory.\n"; exit 1; }

source "$scriptDir/os/utils.sh" \
    || { printf "Failed to load os/utils.sh.\n"; exit 1; }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if [ "$(get_os)" = "osx" ]; then
        "$scriptDir/os/os_x/preferences/main.sh" \
            || { print_error "Failed to apply macOS preferences!"; exit 1; }
    else
        print_error "Sorry, this script is intended only for macOS!"
        exit 1
    fi

}

main
