{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.llama-cpp;
in
{
  options.cave = {
    systemd.services.llama-cpp.enable = lib.mkEnableOption "enable systemd.services.llama-cpp config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        llama-cpp = {
          Unit = {
            Description = "${pkgs.llama-cpp.meta.description}";
            Documentation = "${pkgs.llama-cpp.meta.homepage}";
            Requires = [
              "tray.target"
            ];
            After = [
              "graphical-session.target"
              "tray.target"
            ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            ExecStart = "${pkgs.llama-cpp-rocm}/bin/llama-server -c 16384 --host 0.0.0.0 --port 9931 --sleep-idle-seconds 600";
            Restart = "on-failure";
            KillMode = "mixed";
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
