#!/usr/bin/env bash

# Make sure the "Videos" folder exists
if [ ! -d "$HOME/Videos" ]; then
    mkdir -p "$HOME/Videos"
fi

# Create Menu Items
options=(" Start Recording" " Stop  Recording" " Pause/Resume Recording" " Start   Replay" " Stop    Replay" " Save    Replay")

# Print Menu Items each with a newline
choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p "Recording:")

# Get date for file name
date=$(date +"%d-%m-%Y_%H-%M-%S")

# gpu-screen-recorder options
recording_options=(
    -w "screen"
    -f "60"
    -a "default_output|default_input"
    -o "$HOME/Videos/Video-${date}.mp4"
)

replay_options=(
    -w "screen"
    -f "60"
    -a "default_output|default_input"
    -c "mp4"
    -r "60"
    -o "$HOME/Videos/Clip-${date}.mp4"
)

# Handle selected input
case "$choice" in
"${options[0]}")
    # START RECORDING
    gpu-screen-recorder "${recording_options[@]}"
    exit 0
    ;;
"${options[1]}")
    # STOP RECORDING
    pkill -SIGINT -f gpu-screen-recorder
    exit 0
    ;;
"${options[2]}")
    # PAUSE/RESUME RECORDING
    pkill -SIGUSR2 -f gpu-screen-recorder
    exit 0
    ;;
"${options[3]}")
    # START REPLAY
    gpu-screen-recorder "${replay_options[@]}"
    exit 0
    ;;
"${options[4]}")
    # STOP REPPLAY
    pkill -SIGINT -f gpu-screen-recorder
    exit 0
    ;;
"${options[5]}")
    # SAVE REPLAY
    pkill -SIGUSR1 -f gpu-screen-recorder
    exit 0
    ;;
*)
    echo -e "Error: Option not recognized '${choice}'"
    exit 1
    ;;
esac
