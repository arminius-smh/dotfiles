{ ... }:
{
  imports = [
    # ./activemq
    ./avahi
    # ./blueman
    # ./dbus
    # ./displayManager
    # ./dnsmasq
    # ./envfs
    # ./flatpak
    # ./fstrim
    # ./fwupd # firmware update
    # ./getty
    # ./greetd # display manager daemon
    # ./gvfs
    # ./jupyter
    # ./kubo
    # ./logind
    # ./minecraft-server
    # ./mysql
    ./openssh
    # ./pipewire
    # ./printing
    # ./psd # https://wiki.archlinux.org/title/Profile-sync-daemon
    # ./scx
    # ./tumbler # filemanager thumbnail generator
    # ./udev
    # ./udisks2
    # ./upower
    # ./usbmuxd # needed for iOS data transfer
    ./xserver
    ./zfs
  ];
}
