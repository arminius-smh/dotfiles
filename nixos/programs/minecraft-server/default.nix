{
  inputs,
  pkgs,
  config,
  ...
}: let
  importServer = serverFile: import serverFile {inherit pkgs config;};
in {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  nixpkgs = {
    overlays = [inputs.nix-minecraft.overlay];
  };

  services = {
    minecraft-servers = {
      enable = true;
      eula = true;

      servers = {
        vanilla-fabric-server-1_21_1 = importServer ./vanilla-fabric-server-1_21_1.nix;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      packwiz
      rcon
    ];
  };
}
