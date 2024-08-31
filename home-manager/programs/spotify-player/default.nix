{
  config,
  pkgs,
  ...
}: {
  programs = {
    spotify-player = {
      enable = true;
      catppuccin = {
        enable = true;
      };
      package = pkgs.spotify-player.override {withAudioBackend = "pulseaudio";}; # NOTE: needed cuz some issue with alsa on arm
      settings = {
        client_id = config.secrets.spotifyId;
        device = {
          audio_cache = false;
          normalization = false;
          volume = 100;
          bitrate = 320;
        };
      };
    };
  };
}
