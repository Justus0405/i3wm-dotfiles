#!/usr/bin/env bash
#
# Simple wallpaper picker for rofi
#
# Author: Justus0405
# Date: 14.12.2025
# License: MI

wallpaperDirectory="${HOME}/.config/wallpapers"

# Dont even ask...
chosen=$(
    find "${wallpaperDirectory}" -type f -print0 |
        while IFS= read -r -d '' file; do
            name=$(basename "${file}")
            printf '%s\0icon\x1f%s\n' "${name}" "${file}"
        done |
        rofi -dmenu -i -p " 󰋩 Wallpapers " -show-icons
)

[ -z "${chosen}" ] && exit 0

feh --bg-scale "${wallpaperDirectory}/${chosen}"
