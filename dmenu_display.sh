#!/bin/sh

OPTIONS="Laptop display (eDP1)\nExternal display (HDMI)\nDual display (HDMI + eDP1)\nManual selection"

CHOSEN=$(echo -e "$OPTIONS" | dmenu -i -p "Select your display mode:")

case "$CHOSEN" in
	"Laptop display (eDP1)")	xrandr --output eDP1 --mode 1920x1200 --output HDMI2 --off;;
	"External display (HDMI)")	xrandr --output HDMI2 --auto --output eDP1 --off;;
	"Dual display (HDMI + eDP1)")	xrandr --output HDMI2 --auto --output eDP1 --mode 1920x1200 --right-of HDMI2;;
	"Manual selection")		arandr;;
esac
