{ ... }:
{
  imports = [
    # ./activemq
    ./avahi
    # ./blueman
    # ./dbus
    # ./displayManager
    # ./flatpak
    # ./fstrim
    # ./fwupd # firmware update
    # ./getty
    # ./greetd # display manager daemon
    # ./gvfs
    # ./kubo
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
