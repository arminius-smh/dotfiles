{ pkgs, ... }:
{
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs =
          pkgs: with pkgs; [
            gamemode
          ];
      };
      gamescopeSession = {
        enable = true;
        args = [
          "-W 1920"
          "-H 1080"
          "-f"
          "-b"
          "--force-grab-cursor"
        ];
      };
      remotePlay = {
        openFirewall = true;
      };
      dedicatedServer = {
        openFirewall = true;
      };
    };
  };
}
