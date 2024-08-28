{
  description = "System configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      #url = "git+file:///home/armin/Projects/Coding/nix/nixpkgs?shallow=1";
    };
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "git+file:///home/armin/Projects/Coding/nix/home-manager"; # WAIT: my hyprcursor pr
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
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };
    nil = {
      url = "github:oxalica/nil";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
    };
    nur = {
      url = "github:nix-community/nur";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    home-manager-stable,
    ...
  } @ inputs: let
    disableHomeManagerNews = {
      config = {
        news.display = "silent";
        news.json = inputs.nixpkgs.lib.mkForce {};
        news.entries = inputs.nixpkgs.lib.mkForce [];
      };
    };
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      "phoenix" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
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
        specialArgs = {inherit inputs;};
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
        specialArgs = {inherit inputs;};
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

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "voyager" = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./systems/voyager/home.nix
          disableHomeManagerNews
        ];
        extraSpecialArgs = {
          inherit inputs;
          systemName = "voyager";
        };
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
      };
    };
  };
}
