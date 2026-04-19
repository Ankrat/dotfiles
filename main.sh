#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    || { printf "Failed to change to script directory.\n"; exit 1; }

source "os/utils.sh" \
    || { printf "Failed to load os/utils.sh.\n"; exit 1; }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if [ "$(get_os)" = "osx" ]; then
        ./os/os_x/preferences/main.sh \
            || { print_error "Failed to apply macOS preferences!"; exit 1; }
    else
        print_error "Sorry, this script is intended only for macOS!"
        exit 1
    fi

}

main
