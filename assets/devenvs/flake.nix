{
  description = "Template Collection for Coding";
  outputs =
    { self, ... }:
    {
      templates = {
        mcu = {
          path = ./mcu;
          description = "Simple Microcontroller project";
        };

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

        default = {
          path = ./empty;
          description = "Empty flake template";
        };
      };
    };
}
