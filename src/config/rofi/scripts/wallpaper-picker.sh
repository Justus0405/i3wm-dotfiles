#!/usr/bin/env bash
#
# Simple wallpaper picker for rofi
#
# Author: Justus0405
# Date: 14.12.2025
# License: MI

wallpaperDirectory="${HOME}/.config/wallpapers"

chosen=$(find "${wallpaperDirectory}" -type f -print0 |
    xargs -0 -n1 basename |
    sort |
    rofi -dmenu -i -p "Wallpaper")

[ -z "${chosen}" ] && exit 0

feh --bg-fill "${wallpaperDirectory}/${chosen}"
