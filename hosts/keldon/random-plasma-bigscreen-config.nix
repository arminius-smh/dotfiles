{ pkgs, ... }: {
  # copied from https://github.com/LongerHV/nixos-configuration/blob/f100b28a686888817ef349f0a966c40bed1cb61e/modules/nixos/plasma-bigscreen.nix#L4
  # but works ig?
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    autoLogin = {
      enable = true;
      user = "armin";
    };
    defaultSession = "plasma-bigscreen-wayland";
    sessionPackages = [ pkgs.kdePackages.plasma-bigscreen ];
  };

  environment = {
    systemPackages = with pkgs.kdePackages; [
      plasma-bigscreen
      plasma-nano
    ];
  };
  services.desktopManager.plasma6.enable = true;
  programs = {
    kdeconnect.enable = true;
    xwayland.enable = true;
  };
  xdg.portal.configPackages = [
    pkgs.kdePackages.plasma-workspace
    pkgs.kdePackages.plasma-bigscreen
  ];

  security.polkit.enable = true;
  services.fwupd.enable = false;

  systemd.user = {
    targets.plasma-core = {
      overrideStrategy = "asDropin";
      wants = [ "plasma-kactivitymanagerd.service" ];
    };
    services = {
      plasma-kcminit = {
        overrideStrategy = "asDropin";
        serviceConfig.ExecStart = [
          ""
          "${pkgs.coreutils}/bin/true"
        ];
      };
      plasma-ksmserver = {
        overrideStrategy = "asDropin";
        serviceConfig = {
          ExecStart = [
            ""
            "${pkgs.coreutils}/bin/true"
          ];
          Type = "simple";
          BusName = "";
        };
      };
      plasma-plasmashell = {
        overrideStrategy = "asDropin";
        after = [ "plasma-kactivitymanagerd.service" ];
        serviceConfig.Environment = [
          "XDG_DATA_DIRS=${pkgs.kdePackages.plasma-bigscreen}/share:/etc/profiles/per-user/armin/share:/run/current-system/sw/share"
          "PATH=/etc/profiles/per-user/armin/bin:${pkgs.kdePackages.plasma-bigscreen}/bin:/run/wrappers/bin:/run/current-system/sw/bin"
        ];
      };
      plasma-xdg-desktop-portal-kde = {
        overrideStrategy = "asDropin";
        serviceConfig.Environment = [ "QT_QPA_PLATFORMTHEME=kde" ];
      };
    };
  };

}
