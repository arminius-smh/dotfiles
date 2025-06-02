{ pkgs, ... }:
{
  services = {
    jupyter = {
      enable = true;
      user = "armin";
      notebookDir = "~/projects/dev/misc/jupyter";
      password = "argon2:$argon2id$v=19$m=10240,t=10,p=8$snCBlMr3Un7WfNc5u/Gmxg$y8S5y/g2URIpJ8Y5i7Z1bSEnK88f23goOMlkRQzabWs";
      kernels = {
        python3 =
          let
            env = (
              pkgs.python3.withPackages (
                pythonPackages: with pythonPackages; [
                  ipykernel
                  numpy
                  scipy
                  scikit-learn
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
}
