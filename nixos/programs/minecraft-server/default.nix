{
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs = {
    overlays = [ inputs.nix-minecraft.overlay ];
  };

  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
    ./vanilla-fabric-server-1_21_1.nix
  ];
  services = {
    minecraft-servers = {
      enable = true;
      eula = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      packwiz
      rcon
    ];
  };
}
