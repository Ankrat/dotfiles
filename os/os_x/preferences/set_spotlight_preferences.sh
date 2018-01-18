#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


set_preferences() {

    # Change indexing order and disable some search results
    # Yosemite-specific search results (remove them if your are using OS X 10.9 or older):
    # 	MENU_DEFINITION
    # 	MENU_CONVERSION
    # 	MENU_EXPRESSION
    # 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
    # 	MENU_WEBSEARCH             (send search queries to Apple)
    # 	MENU_OTHER

	
    # execute 'defaults read com.apple.spotlight orderedItems' -array \
	# '{"enabled" = 1;"name" = "APPLICATIONS";}' \
	# '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	# '{"enabled" = 1;"name" = "DIRECTORIES";}' \
	# '{"enabled" = 1;"name" = "PDF";}' \
	# '{"enabled" = 1;"name" = "FONTS";}' \
	# '{"enabled" = 0;"name" = "DOCUMENTS";}' \
	# '{"enabled" = 0;"name" = "MESSAGES";}' \
	# '{"enabled" = 0;"name" = "CONTACT";}' \
	# '{"enabled" = 0;"name" = "EVENT_TODO";}' \
	# '{"enabled" = 0;"name" = "IMAGES";}' \
	# '{"enabled" = 0;"name" = "BOOKMARKS";}' \
	# '{"enabled" = 0;"name" = "MUSIC";}' \
	# '{"enabled" = 0;"name" = "MOVIES";}' \
	# '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	# '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	# '{"enabled" = 0;"name" = "SOURCE";}' \
	# '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
	# '{"enabled" = 0;"name" = "MENU_OTHER";}' \
	# '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	# '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	# '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	# '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
    #     "Set Spotlight search preferences"


	# execute 'defaults write com.apple.spotlight orderedItems' \
	# 	' "{ enabled = 1; name = APPLICATIONS; }" ' \
	# 	' "{ enabled = 1; name = SYSTEM_PREFS; }" ' \
	# 	' "{ enabled = 1; name = DIRECTORIES; }" ' \
	# 	' "{ enabled = 1; name = PDF; }" ' \
	# 	' "{ enabled = 1; name = FONTS; }" ' \
	# 	' "{ enabled = 0; name = DOCUMENTS; }" ' \
	# 	' "{ enabled = 0; name = MESSAGES; }" ' \
	# 	' "{ enabled = 0; name = CONTACT; }" ' \
	# 	' "{ enabled = 0; name = \"EVENT_TODO\"; }" ' \
	# 	' "{ enabled = 0; name = IMAGES; }" ' \
	# 	' "{ enabled = 0; name = BOOKMARKS; }" ' \
	# 	' "{ enabled = 0; name = MUSIC; }" ' \
	# 	' "{ enabled = 0; name = MOVIES; }" ' \
	# 	' "{ enabled = 0; name = PRESENTATIONS; }" ' \
	# 	' "{ enabled = 0; name = SPREADSHEETS; }" ' \
	# 	' "{ enabled = 0; name = SOURCE; }" ' \
	# 		"Set Spotlight search preferences"

	execute 'defaults write com.apple.spotlight orderedItems ({"enabled" = 1;"name" = "APPLICATIONS";},{"enabled" = 1;"name" = "SYSTEM_PREFS";},{"enabled" = 1;"name" = "DIRECTORIES";},{"enabled" = 1;"name" = "PDF";},{"enabled" = 1;"name" = "FONTS";},{"enabled" = 0;"name" = "DOCUMENTS";},{"enabled" = 0;"name" = "MESSAGES";},{"enabled" = 0;"name" = "CONTACT";},{"enabled" = 0;"name" = "EVENT_TODO";},{"enabled" = 0;"name" = "IMAGES";},{"enabled" = 0;"name" = "BOOKMARKS";},{"enabled" = 0;"name" = "MUSIC";},{"enabled" = 0;"name" = "MOVIES";},{"enabled" = 0;"name" = "PRESENTATIONS";},{"enabled" = 0;"name" = "SPREADSHEETS";},{"enabled" = 0;"name" = "SOURCE";})'\
			"Set Spotlight results orderedItems preferences"


}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n  Spotlight\n\n"
    # set_preferences

    # killall "Spotlight" &> /dev/null

	sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
	defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 1;"name" = "DIRECTORIES";}' \
    '{"enabled" = 1;"name" = "PDF";}' \
    '{"enabled" = 1;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "DOCUMENTS";}' \
    '{"enabled" = 0;"name" = "MESSAGES";}' \
    '{"enabled" = 0;"name" = "CONTACT";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
    '{"enabled" = 0;"name" = "MUSIC";}' \
    '{"enabled" = 0;"name" = "MOVIES";}' \
    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 0;"name" = "SOURCE";}'
# Load new settings before rebuilding the index
killall mds
# Make sure indexing is enabled for the main volume
sudo mdutil -i on
# Rebuild the index from scratch
sudo mdutil -E

}

main
