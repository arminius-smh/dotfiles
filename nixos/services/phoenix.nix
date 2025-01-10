{ ... }:
{
  imports = [
    ./udev
    ./avahi
    ./udisks2
    ./getty
    ./xserver
    ./tumbler # filemanager thumbnail generator
    ./fstrim
    ./openssh
    ./dbus
    ./fwupd # firmware update
    ./blueman
    ./psd # https://wiki.archlinux.org/title/Profile-sync-daemon
    ./pipewire
    ./gvfs
    ./scx
  ];
}
