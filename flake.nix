{
  description = "System configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    mypkgs = {
      url = "github:arminius-smh/nixpkgs/mypkgs";
      # url = "git+file:///home/armin/Projects/Coding/nix/nixpkgs/";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      # url = "github:arminius-smh/catppuccin-nix/fcitx5";
      # url = "git+file:///home/armin/Projects/Coding/nix/catppuccin-nix/";
    };
    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      home-manager-stable,
      ...
    }@inputs:
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        "phoenix" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            systemName = "phoenix";
          };
          modules = [
            # > Our main nixos configuration file <
            ./systems/phoenix/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true; # use global nixpkgs instead of home-manager's own
                useUserPackages = true; # install packages to /etc/profiles/ instead of $HOME/.nix-profile
                users = {
                  "armin" = import ./systems/phoenix/home.nix;
                };
                extraSpecialArgs = {
                  inherit inputs;
                  systemName = "phoenix";
                };
              };
            }
          ];
        };
        "excelsior" = nixpkgs-stable.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            systemName = "excelsior";
          };
          modules = [
            ./systems/excelsior/configuration.nix
            home-manager-stable.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                  "armin" = import ./systems/excelsior/home.nix;
                };
                extraSpecialArgs = {
                  inherit inputs;
                  systemName = "excelsior";
                };
              };
            }
          ];
        };
        "discovery" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            systemName = "discovery";
          };
          modules = [
            ./systems/discovery/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                  "armin" = import ./systems/discovery/home.nix;
                };
                extraSpecialArgs = {
                  inherit inputs;
                  systemName = "discovery";
                };
              };
            }
          ];
        };
      };
    };
}
