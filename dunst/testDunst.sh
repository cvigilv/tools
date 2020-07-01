#!/bin/sh

# = testDunst.sh ===============================================================
#
# Test Dunst notifications in common cases
#
# by Carlos Vigil Vásquez
# https://github.com/cvigilv/
# ==============================================================================

# SCRIPT HISTORY
_version_="0.0"
_released_="Currently in development"
_title_="testDunst.sh - $_version_"

# 3 levels of notifications with icon
notify-send -u low "Low Urgency" "This is as test dunst notification with icon" -i "/home/cvigilv/.scripts/dunst/Spotify_Icon_RGB_Green.png"
notify-send -u normal "Normal Urgency" "This is as test dunst notification" -i "/home/cvigilv/.scripts/dunst/Spotify_Icon_RGB_Green.png"
notify-send -u critical "Critial Urgency" "This is as test dunst notification" -i "/home/cvigilv/.scripts/dunst/Spotify_Icon_RGB_Green.png"
