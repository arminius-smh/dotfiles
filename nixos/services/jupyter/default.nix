{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.services.jupyter;
in
{
  options.cave = {
    services.jupyter.enable = lib.mkEnableOption "enable services.jupyter config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      jupyter = {
        enable = true;
        user = "armin";
        port = 8888;
        notebookDir = "~/dev/jupyter";
        password = "argon2:$argon2id$v=19$m=10240,t=10,p=8$snCBlMr3Un7WfNc5u/Gmxg$y8S5y/g2URIpJ8Y5i7Z1bSEnK88f23goOMlkRQzabWs";
        kernels = {
          python3 =
            let
              env = (
                pkgs.python3.withPackages (
                  pythonPackages: with pythonPackages; [
                    ipykernel
                    numpy
                    matplotlib
                  ]
                )
              );
            in
            {
              displayName = "Python_3-custom";
              argv = [
                "${env.interpreter}"
                "-m"
                "ipykernel_launcher"
                "-f"
                "{connection_file}"
              ];
              language = "python";
            };
        };
      };
    };
  };
}
