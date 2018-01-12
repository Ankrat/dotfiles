#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh" \
    && source "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ./install_xcode.sh

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./install_homebrew.sh
    brew_install "Homebrew Cask" "caskroom/cask/brew-cask" "caskroom/cask"

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "zsh"
    brew_install "zsh-completions"
    
    ./change_default_bash_version.sh

    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Android File Transfer" "android-file-transfer" "caskroom/cask" "cask"
    #brew_install "Visual Studio Code" "visual-studio-code" "caskroom/cask" "cask"

    brew_install "Chrome" "google-chrome" "caskroom/cask" "cask"    
    brew_install "Firefox" "firefox" "caskroom/cask" "cask"
    brew_install "Firefox Developer" "firefoxdeveloperedition" "caskroom/versions" "cask"
    brew_install "Opera" "opera" "caskroom/cask" "cask"

    
    # Image traitment optimisation
    brew_install "FFmpeg" "ffmpeg"
    brew_install "ImageAlpha" "imagealpha" "caskroom/cask" "cask"
    brew_install "ImageMagick" "imagemagick --with-webp"
    brew_install "ImageOptim" "imageoptim" "caskroom/cask" "cask"

    # Animated screencapture
    brew_install "LICEcap" "licecap" "caskroom/cask" "cask"

    # Free Office tools
    brew_install "LibreOffice" "libreoffice" "caskroom/cask" "cask"

    #brew_install "tmux" "tmux"
    brew_install "Transmission" "transmission" "caskroom/cask" "cask"
    brew_install "Dropbox" "dropbox" "caskroom/cask" "cask"
    brew_install "Git" "git"
    brew_install "Unarchiver" "the-unarchiver" "caskroom/cask" "cask"
    brew_install "VLC" "vlc" "caskroom/cask" "cask"


    print_in_green "\n  ---\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./update_and_upgrade.sh
    ./cleanup.sh

}

main
