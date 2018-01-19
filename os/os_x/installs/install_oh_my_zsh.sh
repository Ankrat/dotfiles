#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

    declare -r ZSH_DIRECTORY="$HOME/.zsh"
    declare -r OHMYZSH_DIRECTORY="$HOME/.oh-my-zsh"
    declare -r ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    declare -r POWERLINE_GIT_REPOSITORY_URL="https://github.com/powerline/fonts.git"

    declare -r PLUGINS='plugins=(git node npm bower brew osx extract z github jira)'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # local HOMEBREW_PREFIX=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Git` is installed

    if ! cmd_exists "git"; then
        print_error "Git is required, please install it!\n"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    
    # Open up your ZSH preferences at ~/.zshrc and change the theme variable to ZSH_THEME="cobalt2".
    # In iTerm2 access the Preferences pane on the Profiles tab.
    # Under the Colors tab import the cobalt2.itermcolors file via the Load Presets drop-down.
    # Under the Text tab change the font for each type (Regular and Non-ASCII) to 'Inconsolata for Powerline'. (Refer to the powerline-fonts repo for help on font installation.)
    # Refresh ZSH by typing source ~/.zshrc on the command line.
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Powerline fonts
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_info "Getting Inconsolata font for the theme"
    
    git clone "$POWERLINE_GIT_REPOSITORY_URL" --depth=1
    # install
    ./fonts/install.sh Inconsolata
    # clean-up a bit
    rm -rf fonts

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # ohMyZsh
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    print_info "Installing OhMyZsh"

    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh #&> /dev/null
    
    # cat "$OHMYZSH_DIRECTORY/templates/zshrc.zsh-template" > "$HOME/.zshrc" &> /dev/null
    print_result $? "OhMyZsh installed"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # ohMyZsh theme
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Drop the cobalt2.zsh-theme file in to the ~/.oh-my-zsh/themes/ directory.
    curl -LsS https://raw.github.com/Ankrat/Cobalt2-iterm/master/cobalt2.zsh-theme >> "$HOME/.oh-my-zsh/themes/cobalt2.zsh-theme"

    # Open up your ZSH preferences at ~/.zshrc and change the theme variable to ZSH_THEME="cobalt2".
    if grep -rli 'ZSH_THEME="' "$HOME/.zshrc"; then
        grep -rli 'ZSH_THEME="' "$HOME/.zshrc" | xargs -I@ sed -i -e 's/.*ZSH_THEME=".*/ZSH_THEME="cobalt2"/' @
    fi

    
    # Open up your ZSH preferences at ~/.zshrc and change plugins to install.
    # plugins=(git colored-man colorize github jira vagrant virtualenv pip python brew osx zsh-syntax-highlighting)
    if [ $? -eq 0 ]; then
        printf "%s" "$PLUGINS" >> "$HOME/.zshrc"
        print_result $? "ohMyZsh (update ~/.zshrc)"
    fi
    



    print_result $? "Theme added "

    # In iTerm2 access the Preferences pane on the Profiles tab.
    # Under the Colors tab import the cobalt2.itermcolors file via the Load Presets drop-down.
    # Under the Text tab change the font for each type (Regular and Non-ASCII) to 'Inconsolata for Powerline'. (Refer to the powerline-fonts repo for help on font installation.)

    

}

main
