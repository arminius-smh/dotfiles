{ ... }:
{
  programs = {
    gamescope = {
      enable = true;
      capSysNice = false;
      args = [
        "-W 1920"
        "-H 1080"
        "-w 1920"
        "-h 1080"
        "-r 60"
        "-f"
        "--force-grab-cursor"
      ];
    };
  };
}
