#!/bin/sh

# = voronoi ====================================================================
#
# Small wallpaper creator
#
# by Carlos Vigil Vásquez
# https://github.com/cvigilv/
# ==============================================================================

# SCRIPT HISTORY
_version_="0.0"
_released_="Currently in development"
_title_="voronoi - Wallpaper creator $_version_"

# ARGUMENT PARSING
 helper() {
echo
"
Usage: voronoi [arguments]

Arguments:
    -h or --help        Print Help (this message) and exit
    --version           Print version information and exit";
exit 1; }

ver() {
echo
"
Version:        $_version_
Release:        $_released_";
exit 1; }

echo "$_title_"

if [[ -z $1 ]]; then
    echo -e "Usage:\t\t$0 [ --help ] [ --version ]\nMore info with:\t$0 --help"
    exit 1
fi

while getopts :-:h:c:w:H:b:o: arguments;do
    case $arguments in
    -)  # Parse long arguments
        case "${OPTARG}" in
            help)       helper;;
            version)    ver;;
            *)          echo -e "Unknown option argument: \"--${OPTARG}\"\nMore info with: \"$0 --help\"";;
        esac;;
    h)  helper;;
    c)  COLORS=${OPTARG};;
    w)  WIDTH=${OPTARG};;
    H)  HEIGHT=${OPTARG};;
    b)  BLUR=${OPTARG};;
    o)  OUTPUT=${OPTARG};;
    *)  echo -e "Unknown option argument: \"-${OPTARG}\"\nMore info with:\t\"$0 --help\"";;
    esac
done

# DEFAULT VALUES
if [ -z "$HEIGHT" ]; then
    HEIGHT=1080
fi
if [ -z "$WIDTH" ]; then
    WIDTH=1920
fi
if [ -z "$BLUR" ]; then
    BLUR=350
fi
if [ -x "$OUTPUT" ];then
    OUTPUT="voronoi.jpg"
fi

echo "Creating Voronoi wallpaper from the colors: $COLORS"
CELLS=""

for C in $COLORS; do
    CELLS="${CELLS} $((1 + RANDOM % ${WIDTH})),$((1 + RANDOM % ${HEIGHT})) $C"
done

convert -size ${WIDTH}x${HEIGHT} xc: -colorspace sRGB \
    -sparse-color  Voronoi "${CELLS}" \
    -blur 0x${BLUR}  -colorspace sRGB \
    ${OUTPUT}
