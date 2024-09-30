{ lib, ... }:
with lib;
{
  options = {
    secrets = {
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
      spotifyId = mkOption {
        type = types.str;
      };
      minecraft = {
        whitelist = mkOption {
          type = types.attrs;
        };
        ops = mkOption {
          type = types.str;
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
    };
  };
}
