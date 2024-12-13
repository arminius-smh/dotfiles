{ ... }:
{
  programs = {
    nh = {
      enable = true;
      flake = ../../..;
      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 7d";
      };
    };
  };
}
