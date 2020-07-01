#!/bin/sh

# = dunst_spotify ==============================================================
#
# Dunst notification of currently playing song in Spotify
#
# by Carlos Vigil Vásquez
# https://github.com/cvigilv/
# ==============================================================================

_version_="0.0"
_title_="dunst_spotify $_version_"

# Get song information from playerctl
title=$(playerctl metadata --format "{{ title }}")
artist=$(playerctl metadata --format "{{ artist }}")
album=$(playerctl metadata --format "{{ album }}")
art=$(playerctl metadata --format "{{ mpris:artUrl }}")

# Check if album art already exits
if [ "album" != "$SPOTIFY_LAST_ALBUM" ]; then
	wget -O /tmp/spotify_art.png "$art"
	SPOTIFY_LAST_ALBUM="$album"
	export $SPOTIFY_LAST_ALBUM
fi

# Send spotify notification
notify-send "$title" "$artist\n$album" -i /tmp/spotify_art.png
