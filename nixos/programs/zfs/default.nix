{ pkgs, ... }:
{
  services = {
    zfs = {
      autoScrub = {
        enable = true;
        pools = [
          "tank"
        ];
        interval = "monthly";
        randomizedDelaySec = "6h";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      zfs
    ];
  };
}
