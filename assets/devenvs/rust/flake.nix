{
  /*
  echo "use flake ." > .envrc && direnv allow
  */

  description = "rust dev environment";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    ...
  }: let
    systems = ["x86_64-linux" "x86_64-darwin"];
    overlays = [(import rust-overlay)];

    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system:
        f {
          pkgs = import nixpkgs {inherit system overlays;};
        });
  in {
    devShells = forAllSystems ({pkgs}: let
      rust = pkgs.rust-bin.stable.latest.default;
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          rust
        ];

        shellHook = ''
          ${rust}/bin/rustc --version
        '';
      };
    });
  };
}
