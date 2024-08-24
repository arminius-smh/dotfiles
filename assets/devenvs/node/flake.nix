{
  /*
  echo "use flake ." > .envrc && direnv allow
  */

  description = "node dev environment";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs = {nixpkgs, ...}: let
    systems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux"];

    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    devShells = forAllSystems ({pkgs}: let
      nodejs = pkgs.nodejs;
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nodejs
        ];
        shellHook = ''
          ${nodejs}/bin/npm --version
        '';
      };
    });
  };
}
