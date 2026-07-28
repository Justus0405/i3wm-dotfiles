#!/bin/sh
# This file is executed when starting Ly (before the TTY is taken control of)
# Custom startup code can be placed in this file or the start_cmd var can be pointed to a different file

# Catppuccin Mocha by Justus0405
# Colors are in red/green/blue hex (the current colors are a brighter palette than default)

if [ "$TERM" = "linux" ]; then
        BLACK="1E1E2E"          # base
        DARK_RED="F38BA8"       # red
        DARK_GREEN="A6E3A1"     # green
        DARK_YELLOW="F9E2AF"    # yellow
        DARK_BLUE="89B4FA"      # blue
        DARK_MAGENTA="F5C2E7"   # pink
        DARK_CYAN="94E2D5"      # teal
        LIGHT_GRAY="BAC2DE"     # subtext1
        DARK_GRAY="585B70"      # surface2
        RED="F38BA8"            # red
        GREEN="A6E3A1"          # green
        YELLOW="F9E2AF"         # yellow
        BLUE="89B4FA"           # blue
        MAGENTA="F5C2E7"        # pink
        CYAN="94E2D5"           # teal
        WHITE="CDD6F4"          # text

        COLORS="${BLACK} ${DARK_RED} ${DARK_GREEN} ${DARK_YELLOW} ${DARK_BLUE} ${DARK_MAGENTA} ${DARK_CYAN} ${LIGHT_GRAY} ${DARK_GRAY} ${RED} ${GREEN} ${YELLOW} ${BLUE} ${MAGENTA} ${CYAN} ${WHITE}"

        i=0
        while [ $i -lt 16 ]; do
                printf "\033]P%x%s" ${i} "$(echo "$COLORS" | cut -d ' ' -f$(( i + 1)))"

                i=$(( i + 1 ))
        done

        clear # for fixing background artifacting after changing color
fi
