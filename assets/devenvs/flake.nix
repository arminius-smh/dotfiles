{
  description = "Template Collection for Coding";
  outputs =
    { self, ... }:
    {
      templates = {
        rust = {
          path = ./rust;
          description = "Simple Rust project";
        };
        go = {
          path = ./go;
          description = "Simple Go project";
        };

        empty = {
          path = ./empty;
          description = "Empty flake template";
        };
      };
    };
}
