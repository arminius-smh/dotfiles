{
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
}
