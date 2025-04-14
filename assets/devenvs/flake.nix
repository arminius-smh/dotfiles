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
        python = {
          path = ./python;
          description = "Simple Python project";
        };

        empty = {
          path = ./empty;
          description = "Empty flake template";
        };
      };
    };
}
