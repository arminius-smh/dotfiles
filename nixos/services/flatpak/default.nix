{ pkgs, ... }:
{
  services = {
    flatpak = {
      enable = true;
    };
  };

  environment = {
    sessionVariables = {
      XDG_DATA_DIRS = [ "/var/lib/flatpak/exports/share" ];
    };
  };

  # systemd = {
  #   services = {
  #     flatpak-repo = {
  #       wantedBy = [ "multi-user.target" ];
  #       path = [ pkgs.flatpak ];
  #       script = ''
  #         flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #       '';
  #     };
  #   };
  # };
}
