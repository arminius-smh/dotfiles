{
  description = "Template Collection for Coding";
  outputs = {self, ...}: {
    templates = {
      rust = {
        path = ./rust;
        description = "Simple Rust project";
      };
      python = {
        path = ./python;
        description = "Simple Python project";
      };
      vala = {
        path = ./vala;
        description = "Simple Vala project";
      };
      node = {
        path = ./node;
        description = "Simple Node project";
      };
    };
  };
}
