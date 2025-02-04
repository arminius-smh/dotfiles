#!/usr/bin/env bash
Help()
{
    echo "rebuild nixos-systems"
    echo
    echo "syntax: rebuild -[h|u|t|s|b|B|i]"
    echo "options:"
    echo "h     print this help"
    echo "u     update nix flake"
    echo "t     test(no boot entry) new config"
    echo "s     switch to new config"
    echo "b     only boot-entry for new config"
    echo "B     only build new config"
    echo "i     interactive, only used for auto-update (run as root)"
    echo
}
COMMAND=""
OPTIONS=""

while getopts ":hutsbBi" option; do
    case $option in
        h)
            Help
            exit ;;
        u)
            update=true ;;
        t)
            COMMAND_OVERRIDE="test" ;;
        s)
            COMMAND_OVERRIDE="switch" ;;
        b)
            COMMAND_OVERRIDE="boot" ;;
        B)
            COMMAND_OVERRIDE="build" ;;
        i)
            interactive=true ;;
        \?)
            echo "Error: invalid option"
            exit ;;
    esac
done

DATE=$(date)
hostname=$(hostname)

echo "[$DATE] Starting NixOS update"

if [[ "$interactive" == true ]]; then
    USER="armin"
    BUS_ADDRESS="unix:path=/run/user/1000/bus"

    cd "/home/armin/dotfiles" || { echo "[$DATE] Failed to cd into dotfiles directory"; exit 1; }
    if ! sudo -u armin git add --all; then
        echo "[$DATE] Failed to run 'git add'"
        exit 1
    fi

    if ! sudo -u armin nix flake update; then
        echo "[$DATE] Failed to run 'nix flake update'"
        exit 1
    fi

    # check status of merged prs
    sudo -u armin DBUS_SESSION_BUS_ADDRESS="$BUS_ADDRESS" DISPLAY=:0 \
        /home/armin/dotfiles/assets/scripts/nix-pr-notify.sh

    if ! /run/current-system/sw/bin/nixos-rebuild boot --flake "/home/armin/dotfiles?submodules=1#$hostname" &> /tmp/auto-update.log ; then
        echo "[$DATE] nixos-rebuild failed"
        sudo -u armin DBUS_SESSION_BUS_ADDRESS="$BUS_ADDRESS" DISPLAY=:0 \
            notify-send 'NixOS' '[auto-update] failure: check /tmp/auto-update.log for more info' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -u critical
        exit 1
    fi
    echo "[$DATE] NixOS update completed successfully"
    sudo -u armin DBUS_SESSION_BUS_ADDRESS="$BUS_ADDRESS" DISPLAY=:0 \
        notify-send 'NixOS' '[auto-update] success' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -e
    exit 0
fi

pushd "$HOME/dotfiles" || { echo "[$DATE] Failed to cd into dotfiles directory"; exit 1; }
git pull
git submodule update --recursive

# skip formatting for excelsior due to version differences in nixfmt
if [[ "$hostname" != "excelsior" ]]; then
    treefmt
fi
echo "NixOS Rebuilding..."

git add --all # add all files for the rebuild

if [[ "$hostname" == "phoenix" ]]; then
    COMMAND="switch"
    OPTIONS=""
elif [[ "$hostname" == "discovery" ]]; then
    COMMAND="switch"
    OPTIONS="-- --impure"
elif [[ "$hostname" == "excelsior" ]]; then
    COMMAND="boot"
    OPTIONS=""
fi

if [[ -v COMMAND_OVERRIDE ]]; then
    COMMAND=$COMMAND_OVERRIDE
fi

if [[ "$update" == true ]]; then
    COMMAND+=" --update"
fi

echo "COMMAND: $COMMAND"

# shellcheck disable=SC2086
if ! nh os $COMMAND -H "$hostname" '.?submodules=1' $OPTIONS; then
    echo "NixOS rebuild failed"
    exit
fi

git add --all # in case flake.lock changes
popd || exit
