{ ... }:
{
  programs = {
    dconf = {
      enable = true; # virt-manager requires dconf to remember settings
    };
  };
}
