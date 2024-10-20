{
  config,
  ...
}:
{
  programs = {
    spotify-player = {
      enable = true;
      catppuccin = {
        enable = true;
      };
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
