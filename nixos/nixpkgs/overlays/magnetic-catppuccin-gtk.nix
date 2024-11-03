{ ... }:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        magnetic-catppuccin-gtk = prev.magnetic-catppuccin-gtk.overrideAttrs (oldAttrs: {
          pname = "magnetic-catppuccin-gtk";
          version = "unstable-2024-10-29";

          src = prev.fetchFromGitHub {
            owner = "Fausto-Korpsvart";
            repo = "Catppuccin-GTK-Theme";
            rev = "39e554411ee899574f2e8de449852cae6b56c8fe";
            sha256 = "sha256-XMB9i4yArVbwnkrBkLl3jTMyFf0ZEGeQ+p0otN3BWjk=";
          };
        });
      })
    ];
  };
}
