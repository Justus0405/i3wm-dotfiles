#!/usr/bin/env bash
#
# Simple powermenu for rofi
#
# Author: Justus0405
# Date: 14.12.2025
# License: MIT

askAction() {
    # Create Menu Items
    optionsAction=(" Shut down" "󰜉 Reboot" "󰒲 Suspend" "󰋊 Hibernate" "󰗽 Log out" " Lock screen")

    # Print Menu Items each with a newline
    action=$(printf '%s\n' "${optionsAction[@]}" | rofi -dmenu -i -p " 󰚥 Power ")

    # Handle selected input
    case "${action}" in
    "${optionsAction[0]}")
        # Shut down
        askConfirm "poweroff"
        exit 0
        ;;
    "${optionsAction[1]}")
        # Reboot
        askConfirm "reboot"
        exit 0
        ;;
    "${optionsAction[2]}")
        # Suspend
        askConfirm "systemctl suspend"
        exit 0
        ;;
    "${optionsAction[3]}")
        # Hibernate
        askConfirm "systemctl hibernate"
        exit 0
        ;;
    "${optionsAction[4]}")
        # Log out
        # NOTE:
        # WHY DOES MY SYSTEM COREDUMP WHEN I LOG OUT WITH VSCODIUM RUNNING???
        askConfirm "i3-msg exit"
        exit 0
        ;;
    "${optionsAction[5]}")
        # Lock screen
        askConfirm "loginctl lock-session ${XDG_SESSION_ID-}"
        exit 0
        ;;
    *)
        echo -e "Error: Option not recognized '${action}'"
        exit 1
        ;;
    esac

}

askConfirm() {
    # Create Menu Items
    confirmOptions=(" Yes" " No")

    # Print Menu Items each with a newline
    confirm=$(printf '%s\n' "${confirmOptions[@]}" | rofi -dmenu -i -p " 󰚥 Are you sure? ")

    # Handle selected input
    case "${confirm}" in
    "${confirmOptions[0]}")
        $1
        ;;
    "${confirmOptions[1]}")
        exit 0
        ;;
    *)
        echo -e "Error: Option not recognized '${confirm}'"
        exit 1
        ;;
    esac
}

### PROGRAM START ###

askAction
