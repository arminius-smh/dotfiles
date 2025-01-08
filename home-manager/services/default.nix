{
  systemName,
  ...
}:
let
  options = {
    phoenix = ./phoenix.nix;
    excelsior = ./excelsior.nix;
    discovery = ./discovery.nix;
  };
  services = builtins.getAttr systemName options;
in
{
  imports = [
    services
  ];
}
