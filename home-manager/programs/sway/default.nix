{
  pkgs,
  ...
}:
{
  imports = [
    ./settings.nix
    ./keybindings.nix
  ];
  wayland = {
    windowManager = {
      sway = {
        enable = true;
        xwayland = true;
        checkConfig = true;
        wrapperFeatures = {
          gtk = true;
        };
      };
    };
  };

  home = {
    packages = with pkgs; [
      autotiling # sway dynamic tiling
    ];
  };
}
