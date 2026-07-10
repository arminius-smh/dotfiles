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
      url = "github:nixos/nixpkgs/nixos-26.05";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixos-apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
    };
    qml-niri = {
      url = "github:imiric/qml-niri/main";
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
            ./hosts/phoenix/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true; # use global nixpkgs instead of home-manager's own
                useUserPackages = true; # install packages to /etc/profiles/ instead of $HOME/.nix-profile
                users = {
                  "armin" = import ./hosts/phoenix/home.nix;
                };
                extraSpecialArgs = {
                  inherit inputs;
                  systemName = "phoenix";
                };
              };
            }
          ];
        };
        "keldon" = nixpkgs-stable.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            systemName = "keldon";
          };
          modules = [
            ./hosts/keldon/configuration.nix
            home-manager-stable.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                  "armin" = import ./hosts/keldon/home.nix;
                };
                extraSpecialArgs = {
                  inherit inputs;
                  systemName = "keldon";
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
            ./hosts/discovery/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                  "armin" = import ./hosts/discovery/home.nix;
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
