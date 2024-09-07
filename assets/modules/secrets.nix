{lib, ...}:
with lib; {
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
          type = let
            minecraftUUID =
              lib.types.strMatching
              "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}"
              // {
                description = "Minecraft UUID";
              };
          in
            lib.types.attrsOf minecraftUUID;
        };
        ops = mkOption {
          type = types.str;
        };
        rcon-pw = mkOption {
          type = types.str;
        };
      };
    };
  };
}
