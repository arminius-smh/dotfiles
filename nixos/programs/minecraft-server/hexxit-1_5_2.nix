{
  config,
  pkgs,
  systemName,
  lib,
  ...
}:
let
  serverName = "hexxit-1_5_2";
  txtList =
    { }:
    {
      type = with lib.types; listOf str;
      generate = name: value: pkgs.writeText name (lib.concatStringsSep "\n" value);
    };
in
{
  services = {
    minecraft-servers = {
      servers = {
        ${serverName} = {
          enable = false;
          package = pkgs.hexxit-server;
          serverProperties = {
            white-list = true;
            difficulty = "hard";
            motd = "A Hexxit Server";
            enable-rcon = true;
            "rcon.password" = config.secrets.minecraft.rcon-pw;
          };
          symlinks = {
            "mods" = "${pkgs.hexxit-server}/lib/minecraft/mods";
            "choremods" = "${pkgs.hexxit-server}/lib/minecraft/coremods";
            "config" = "${pkgs.hexxit-server}/lib/minecraft/config";
            "Chocolate" = "${pkgs.hexxit-server}/lib/minecraft/Chocolate";
            "lib" = "${pkgs.hexxit-server}/lib/minecraft/lib";

          };
          # nedded since mc version >=1.7.6 started using uuid
          files = {
            "white-list.txt" = {
              format = txtList { };
              value = builtins.attrNames config.secrets.minecraft.whitelist;
            };
            "ops.txt" = {
              format = txtList { };
              value = builtins.attrNames config.secrets.minecraft.operators;
            };
          };
        };
      };
    };
  };

  systemd =
    lib.mkIf
      (systemName == "excelsior" && config.services.minecraft-servers.servers.${serverName}.enable)
      {
        services = {
          "minecraft-server-${serverName}-backup" = {
            description = "Backup the Minecraft World of ${serverName}";
            script = ''
              ${pkgs.gnutar}/bin/tar -cvp --use-compress-program=${pkgs.gzip}/bin/gzip -f "/tank/users/armin/backups/minecraft/${serverName}-$(date +%F_%R).tar.gz" "/srv/minecraft/${serverName}/world"
            '';
            serviceConfig = {
              Type = "oneshot";
            };
          };
        };
        timers = {
          "minecraft-server-${serverName}-backup" = {
            description = "Daily Minecraft World Backup of ${serverName}";
            timerConfig = {
              OnCalendar = "daily";
              Persistent = true;
            };
            wantedBy = [ "timers.target" ];
          };
        };
      };
}
