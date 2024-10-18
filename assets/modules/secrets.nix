{ lib, ... }:
with lib;
{
  options = {
    secrets = {
      webdav-selfhost = mkOption {
        type = types.str;
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
      homepage = mkOption {
        type = types.str;
      };
    };
  };
}
