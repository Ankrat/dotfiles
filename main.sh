#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "os/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if [ "$(get_os)" == "osx" ]; then
        ./os/os_x/preferences/main.sh
    else
        print_error "Sorry, this script is intended only for OS X!"
        exit 1
    fi

}

main
