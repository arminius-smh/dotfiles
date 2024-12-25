{
  config,
  ...
}:
{
  catppuccin = {
    spotify-player = {
      enable = true;
    };
  };

  programs = {
    spotify-player = {
      enable = true;
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
