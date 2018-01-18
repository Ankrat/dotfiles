#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "utils.sh"

declare -r -a NODE_VERSIONS=(
    "5.0"
    "node"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r NVM_DIRECTORY="$HOME/.nvm"
    declare -r NVM_GIT_REPOSITORY_URL="https://github.com/creationix/nvm.git"

    declare -r CONFIGS='
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Node Version Manager

export NVM_DIR="'$NVM_DIRECTORY'"
[ -f "$NVM_DIR/nvm.sh" ] \
    && source "$NVM_DIR/nvm.sh"

[ -f "$NVM_DIR/bash_completion" ] \
    && source $NVM_DIR/bash_completion
'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Git` is installed

    if ! cmd_exists "git"; then
        print_error "Git is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install `nvm` and add the necessary configs to `~/.bash.local`

    if [ ! -d "$NVM_DIRECTORY" ]; then
        
        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        # Trigger a FATAL ERROR NOT A GIT REPO
        # FIX ? => git init $NVM_DIRECTORY
        cd "$NVM_DIRECTORY" \
            && git init &> /dev/null
        # Return to the setup.sh directory
        cd "$(dirname "$BASH_SOURCE")"
        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -        
        git clone "$NVM_GIT_REPO_URL" "$NVM_DIRECTORY" &> /dev/null
        print_result $? "nvm"

        if [ $? -eq 0 ]; then
            printf "%s" "$CONFIGS" >> "$HOME/.bash.local" \
                && source "$HOME/.bash.local"
            print_result $? "nvm (update ~/.bash.local)"
        fi
        
        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        # Replacement script
        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        # curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | NVM_DIR=$NVM_DIRECTORY PROFILE=$HOME/.bash.local bash
        # touch $HOME/.bash.local
    fi

    if [ -d "$NVM_DIRECTORY" ]; then

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Ensure the latest version of `nvm` is used

        cd "$NVM_DIRECTORY" \
            && git checkout `git describe --abbrev=0 --tags` &> /dev/null
        print_result $? "nvm (update)"

        source "$NVM_DIRECTORY/nvm.sh"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Install the specified `node` versions

        for i in ${NODE_VERSIONS[@]}; do
            execute "nvm install $i" "nvm (install: $i)"
        done

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # By default, use the latest stable version of `node`

        execute "nvm alias default node" "nvm (set default)"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    fi

}

main
