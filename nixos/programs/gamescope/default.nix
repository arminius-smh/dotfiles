{ ... }:
{
  programs = {
    gamescope = {
      enable = true;
      capSysNice = false;
      args = [
        "-W 3840"
        "-H 2160"
        "-r 144"
        "-f"
        "--force-grab-cursor"
      ];
    };
  };
}
