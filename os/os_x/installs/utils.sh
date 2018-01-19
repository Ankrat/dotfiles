#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install() {

    declare -r CMD="$4"
    declare -r FORMULA="$2"
    declare -r FORMULA_READABLE_NAME="$1"
    declare -r TAP_VALUE="$3"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Homebrew` is installed

    if ! cmd_exists "brew"; then
        print_error "$FORMULA_READABLE_NAME (\`brew\` is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If `brew tap` needs to be executed, check if it executed correctly

    if [ -n "$TAP_VALUE" ]; then
        if ! brew_tap "$TAP_VALUE"; then
            print_error "$FORMULA_READABLE_NAME (\`brew tap $TAP_VALUE\` failed)"
            return 1
        fi
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specified formula

    if brew "$CMD" list "$FORMULA" &> /dev/null; then
        print_success "$FORMULA_READABLE_NAME"
    else
        execute "brew $CMD install $FORMULA" "$FORMULA_READABLE_NAME"
    fi

}

brew_tap() {
    brew tap "$1" &> /dev/null
}


#!/bin/bash
#
# Open new iTerm window from the command line
#
# Usage:
#     iterm                   Opens the current directory in a new iTerm window
#     iterm [PATH]            Open PATH in a new iTerm window
#     iterm [CMD]             Open a new iTerm window and execute CMD
#     iterm [PATH] [CMD] ...  You can prob'ly guess
#
# Example:
#     iterm ~/Code/HelloWorld ./setup.sh
#
# References:
#     iTerm AppleScript Examples:
#     https://gitlab.com/gnachman/iterm2/wikis/Applescript
# 
# Credit:
#     Inspired by tab.bash by @bobthecow
#     link: https://gist.github.com/bobthecow/757788
#


iterm () {

    declare -r OS="$(get_os)"

    if [ "$OS" != "osx" ]; then
        exit 1
    fi

    local cmd=""
    local wd="$PWD"
    local args="$@"

    if [ -d "$1" ]; then
        wd="$1"
        args="${@:2}"
    fi

    if [ -n "$args" ]; then
        # echo $args
        cmd="; $args"
    fi

    osascript &>/dev/null <<EOF
        tell application "iTerm"
            activate
            set term to (make new terminal)
            tell term
                launch session "Default Session"
                tell the last session
                    delay 1
                    write text "cd $wd$cmd"
                end
            end
        end tell
EOF
}
