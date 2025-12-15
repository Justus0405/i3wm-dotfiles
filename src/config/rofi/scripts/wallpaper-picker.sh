#!/usr/bin/env bash
#
# Simple wallpaper picker for rofi
#
# Author: Justus0405
# Date: 14.12.2025
# License: MIT

wallpaperDirectory="${HOME}/.config/wallpapers"

# Recursivly find all files in wallpaperDirectory and map them inside a array.
# Example:
#   files[0] = "/home/user/.config/wallpapers/foo.png"
#   files[1] = "/home/user/.config/wallpapers/anime/bar.jpg"
mapfile -d '' files < <(find "${wallpaperDirectory}" -type f -print0)

chosen_index=$(
    for file in "${files[@]}"; do
        name=$(basename "${file}")

        # Print a rofi entry with icons.
        #
        # <label>\0icon\x1f<path>
        #
        # \0        -> separates the label from metadata.
        # icon\x1f  -> tells rofi that the following value is an icon path.
        # "${file}" -> full image path used for thumbnail rendering.
        #
        # Example:
        #   foo.png\0icon\x1f/home/user/.config/wallpapers/foo.png
        printf '%s\0icon\x1f%s\n' "${name}" "${file}"
        # -format 'i' -> output the index of the selected entry.
    done | rofi -dmenu -i -p " 󰋩 Wallpapers " -show-icons -format 'i'
)

[ -z "${chosen_index}" ] && exit 0

# Use the selected index to retrieve the full path
# from the ${files[@]} array and pass it to feh.
feh --bg-fill "${files[${chosen_index}]}"
