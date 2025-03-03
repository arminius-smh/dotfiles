#!/usr/bin/env bash
# NOTE: SOURCE - https://github.com/ericmurphyxyz/dotfiles/blob/d10d652a7f718f504a33e51d3f617fe4dfb0539c/.local/bin/battery-charging#L6

# Send a notification when the laptop is plugged in/unplugged

export XAUTHORITY=~/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# udev rules recognize multiple events, mitigate this with lockfiles
CHARGING_FILE=/tmp/batterycharging
DISCHARGING_FILE=/tmp/batterydischarging

BATTERY_STATE=$1
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')
BATTERY_LEVEL_ROUNDED=$(( (BATTERY_LEVEL + 9) / 10 * 10 ))
BATTERY_LEVEL_FORMATTED=$(printf "%03d" "$BATTERY_LEVEL_ROUNDED")

if [ "$BATTERY_STATE" == "charging" ]; then
    if [ -f "$CHARGING_FILE" ]; then
        exit
    else
        BATTERY_CHARGING="Charging"
        BATTERY_ICON="$BATTERY_LEVEL_FORMATTED-charging"

        touch "$CHARGING_FILE"
        if [ -f "$DISCHARGING_FILE" ]; then
            rm "$DISCHARGING_FILE"
        fi
    fi
elif [ "$BATTERY_STATE" == "discharging" ]; then
    if [ -f "$DISCHARGING_FILE" ]; then
        exit
    else
        BATTERY_CHARGING="Discharging"
        BATTERY_ICON="$BATTERY_LEVEL_FORMATTED"

        touch "$DISCHARGING_FILE"
        if [ -f "$CHARGING_FILE" ]; then
            rm "$CHARGING_FILE"
        fi
    fi
fi

# Send notification
notify-send "${BATTERY_CHARGING}" "${BATTERY_LEVEL}% of battery charged." -u normal -i "battery-${BATTERY_ICON}" -t 5000 -r 9991 -e
