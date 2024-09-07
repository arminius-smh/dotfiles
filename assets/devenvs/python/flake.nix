{
  # use either python3Packages or pip via venv

  # echo "use flake ." > .envrc && direnv allow

  description = "python dev environment";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
      ];

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forAllSystems (
        { pkgs }:
        let
          python = pkgs.python3;
          pythonPackages = pkgs.python3Packages;
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              python
              pythonPackages.pylint
            ];
            shellHook = ''
              ${python}/bin/python --version
              if [ ! -d .venv ]; then
                ${python}/bin/python -m venv .venv
                source .venv/bin/activate
              fi
              source .venv/bin/activate
            '';
          };
        }
      );
    };
}
