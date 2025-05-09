#!/bin/sh
# NOTE: SOURCE - https://github.com/ericmurphyxyz/dotfiles/blob/d10d652a7f718f504a33e51d3f617fe4dfb0539c/.local/bin/battery-alert#L9

# Send a notification if the laptop battery is either low or is fully charged.
# Set on a systemd timer

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# Battery percentage at which to notify
WARNING_LEVEL=20
CRITICAL_LEVEL=10
BATTERY_DISCHARGING=$(acpi -b | grep "Battery 0" | grep -c "Discharging")
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')

# Use files to store whether we've shown a notification or not (to prevent multiple notifications)
FULL_FILE=/tmp/batteryfull
EMPTY_FILE=/tmp/batteryempty
CRITICAL_FILE=/tmp/batterycritical

# Reset notifications if the computer is charging/discharging
if [ "$BATTERY_DISCHARGING" -eq 1 ] && [ -f $FULL_FILE ]; then
    rm $FULL_FILE
elif [ "$BATTERY_DISCHARGING" -eq 0 ]; then
    if [ -f $EMPTY_FILE ]; then
        rm $EMPTY_FILE
    fi
    if [ -f $CRITICAL_FILE ]; then
        rm $CRITICAL_FILE
    fi
fi

# If the battery is charging and is full (and has not shown notification yet)
# Mac Battery only loads until 98
if [ "$BATTERY_LEVEL" -ge 98 ] && [ "$BATTERY_DISCHARGING" -eq 0 ] && [ ! -f $FULL_FILE ]; then
    notify-send "Battery Charged" "Battery is fully charged." -i "battery"
    touch $FULL_FILE
    # If the battery is low and is not charging (and has not shown notification yet)
elif [ "$BATTERY_LEVEL" -le $WARNING_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ] && [ ! -f $EMPTY_FILE ]; then
    notify-send "Low Battery" "${BATTERY_LEVEL}% of battery remaining." -u critical -i "battery-020"
    touch $EMPTY_FILE
    # If the battery is critical and is not charging (and has not shown notification yet)
elif [ "$BATTERY_LEVEL" -le $CRITICAL_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ] && [ ! -f $CRITICAL_FILE ]; then
    notify-send "Battery Critical" "The computer will shutdown soon." -u critical -i "battery-010"
    touch $CRITICAL_FILE
fi
