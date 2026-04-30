#!/usr/bin/env bash

SOUND_ON="$HOME/dotfiles/assets/sounds/microphone-activated.mp3"
SOUND_OFF="$HOME/dotfiles/assets/sounds/microphone-muted.mp3"

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

MONITOR=$(niri msg -j focused-output | jq -r .name)

if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"; then
    swayosd-client --monitor "$MONITOR" \
        --custom-message 'Microphone Muted' \
        --custom-icon 'source-volume-muted-symbolic'
    
    mpv "$SOUND_OFF" --no-video --volume=80 &
else
    swayosd-client --monitor "$MONITOR" \
        --custom-message 'Microphone Active' \
        --custom-icon 'source-volume-high-symbolic'
    
    mpv "$SOUND_ON" --no-video --volume=80 &
fi
