{
  description = "A Collection of Personal Nix Flake Templates";

  outputs = { self, ... }: {
    templates = {
      empty = {
        path = ./empty;
        description = "An empty template that does nothing much.";
      };

      defaultTemplate = self.templates.empty;
    };
  };
}
