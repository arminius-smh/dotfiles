{ ... }:
{
  imports = [
    ./udev
    ./avahi
    ./udisks2
    ./xserver
    ./tumbler # filemanager thumbnail generator
    ./fstrim
    ./openssh
    ./dbus
    ./fwupd # firmware update
    ./blueman
    ./psd # https://wiki.archlinux.org/title/Profile-sync-daemon
    ./pipewire
    ./displayManager
    ./gvfs
    # ./scx
  ];
}
