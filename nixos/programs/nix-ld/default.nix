{ pkgs, ... }:
{
  programs = {
    nix-ld = {
      enable = true;

      # I have no idea if it is okay to set something like this here
      # should this rather be done for every individual dev env?
      # does this break anything else?
      libraries = with pkgs; [
        alsa-lib
        at-spi2-atk
        cairo
        cups
        dbus
        expat
        glib
        gtk3
        libdrm
        libxkbcommon
        mesa
        nspr
        nss
        pango
        xorg.libX11
        xorg.libXcomposite
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXrandr
        xorg.libxcb
      ];
    };
  };
}
