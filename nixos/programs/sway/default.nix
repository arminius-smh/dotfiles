{ ... }:
{
  programs = {
    sway = {
      enable = true;
      wrapperFeatures = {
        gtk = true;
      };
      extraOptions = [ "--unsupported-gpu" ];
    };
  };
}
