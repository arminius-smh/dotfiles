{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      # quickshell
    ];
  };

  systemd = {
    user = {
      services = {
        quickshell = {
          Unit = {
            X-SwitchMethod = "restart";
            ConditionEnvironment = "XDG_SESSION_DESKTOP=Hyprland";

            PartOf = lib.mkForce [
              config.wayland.systemd.target
              "tray.target"
            ];
            After = lib.mkForce [ config.wayland.systemd.target ];
          };
          Service = {
            ExecStart = "${pkgs.quickshell}/bin/quickshell --path ${config.home.homeDirectory}/dotfiles/modules/windowManager/home-manager/programs/quickshell/config";
            Restart = "always"; # optional, if you want it auto-restart
          };
          Install.WantedBy = [
            config.wayland.systemd.target
            "tray.target"
          ];
        };
      };
    };
  };
}
