#!/bin/bash
# Script for Random Wallpaper ( CTRL ALT W)
set -x

wallDIR="$HOME/.config/hypr-wallpapers"
scriptsDir="$HOME/.config/hypr/scripts"

PICS=($(find -L ${wallDIR} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
RANDOMPICS=${PICS[$RANDOM % ${#PICS[@]}]}

echo $RANDOMPICS

# Transition config
FPS=60
TYPE="any"
DURATION=0.5
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

swww query || swww init && swww img ${RANDOMPICS} $SWWW_PARAMS

${scriptsDir}/wallpaperAndStyle/PywalSwww.sh
sleep 1
${scriptsDir}/wallpaperAndStyle/Refresh.sh
