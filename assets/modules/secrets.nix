{ lib, ... }:
with lib;
{
  options = {
    secrets = {
      wifi = {
        profiles = mkOption {
          type = types.attrs;
        };
      };
      settings = {
        startpage = mkOption {
          type = types.str;
        };
      };
      syncthing = {
        excelsior = mkOption {
          type = types.str;
        };
        phoenix = mkOption {
          type = types.str;
        };
        discovery = mkOption {
          type = types.str;
        };
      };
      ip = {
        webdav-selfhost = mkOption {
          type = types.str;
        };
        excelsior = mkOption {
          type = types.str;
        };
        homepage = mkOption {
          type = types.str;
        };
      };
      mail = {
        personal = mkOption {
          type = types.str;
        };
        university = mkOption {
          type = types.str;
        };
      };
      fullName = mkOption {
        type = types.str;
      };
      userNames = {
        university = mkOption {
          type = types.str;
        };
      };
      tokens = {
        git = mkOption {
          type = types.str;
        };
      };
      spotifyId = mkOption {
        type = types.str;
      };
      minecraft = {
        whitelist = mkOption {
          type = types.attrs;
        };
        operators = mkOption {
          type = types.attrs;
        };
        rcon-pw = mkOption {
          type = types.str;
        };
      };
      bookmarks = {
        priv = mkOption {
          type = types.attrs;
        };
      };
      firefox = {
        extensions = {
          settings = mkOption {
            type = types.attrs;
          };
        };
      };
      anki = {
        username = mkOption {
          type = types.str;
        };
        key = mkOption {
          type = types.str;
        };
      };
    };
  };
}
