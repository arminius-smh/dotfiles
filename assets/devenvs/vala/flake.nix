{
  /*
  echo "use flake ." > .envrc && direnv allow
  */

  description = "vala dev environment";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs = {nixpkgs, ...}: let
    systems = ["x86_64-linux" "x86_64-darwin"];

    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    devShells = forAllSystems ({pkgs}: let
      vala = pkgs.vala;
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          vala
          pkg-config
          gobject-introspection
          wrapGAppsHook
        ];

        shellHook = ''
          ${vala}/bin/valac --version
        '';
      };
    });
  };
}
