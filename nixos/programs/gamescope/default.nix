{ ... }:
{
  programs = {
    gamescope = {
      enable = true;
      capSysNice = false;
      args = [
        "-W 1920"
        "-H 1080"
        "-f"
        "--force-grab-cursor"
      ];
    };
  };
}
