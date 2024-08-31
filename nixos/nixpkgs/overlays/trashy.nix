{...}: {
  nixpkgs = {
    overlays = [
      # WAIT: new release of trashy
      (final: prev: {
        trashy = prev.trashy.overrideAttrs (oldAttrs: rec {
          pname = "trashy";
          version = "unstable-2024-01-19";

          src = prev.fetchFromGitHub {
            owner = "oberblastmeister";
            repo = "trashy";
            rev = "7c48827e55bca5a3188d3de44afda3028837b34b";
            sha256 = "sha256-1pxmeXUkgAITouO0mdW6DgZR6+ai2dax2S4hV9jcJLM=";
          };

          postInstall = prev.lib.optionalString (prev.stdenv.buildPlatform.canExecute prev.stdenv.hostPlatform) ''
            installShellCompletion --cmd trashy \
              --bash <($out/bin/trashy completions bash) \
              --fish <($out/bin/trashy completions fish) \
              --zsh <($out/bin/trashy completions zsh) \
          '';

          cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
            name = "${pname}-vendor.tar.gz";
            inherit src;
            outputHash = "sha256-2QITAwh2Gpp+9JtJG77hcXZ5zhxwNztAtdfLmPH4J3Y=";
          });
        });
      })
    ];
  };
}
