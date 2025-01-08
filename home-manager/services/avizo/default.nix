{ ... }:
{
  services = {
    avizo = {
      enable = true;
      settings = {
        default = {
          time = 1.0;
          fade-in = 0.1;
          fade-out = 0.2;
        };
      };
    };
  };
}
