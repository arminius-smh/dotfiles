{ ... }:
{
  system = {
    # NOTE: own bash script + systemd works better
    # autoUpgrade = {
    #   enable = false;
    #   persistent = true;
    #   operation = "boot";
    #   flake = "/home/armin/dotfiles?submodules=1";
    #   dates = "04:40";
    #   allowReboot = false;
    # };
  };
}
