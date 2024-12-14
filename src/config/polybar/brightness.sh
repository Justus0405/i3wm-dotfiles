#!/bin/bash

BRIGHTNESS=$(brightnessctl get)
MAX_BRIGHTNESS=$(brightnessctl max)
PERCENTAGE=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

if [[ "$1" == "up" ]]; then
    brightnessctl set +10%
elif [[ "$1" == "down" ]]; then
    brightnessctl set 10%-
fi

NEW_BRIGHTNESS=$(brightnessctl get)
NEW_PERCENTAGE=$((NEW_BRIGHTNESS * 100 / MAX_BRIGHTNESS))

echo "🔅$NEW_PERCENTAGE%"

