{ pkgs, config, ... }:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        adi1090x-plymouth-themes = prev.adi1090x-plymouth-themes.overrideAttrs (old: {
          installPhase =
            old.installPhase
            + ''
              cp ${pkgs.nixos-icons}/share/icons/hicolor/96x96/apps/nix-snowflake.png $out/share/plymouth/themes/${config.boot.plymouth.theme}/nixos-logo.png
              echo "
              nixos_image = Image(\"nixos-logo.png\");
              nixos_sprite = Sprite();

              nixos_sprite.SetImage(nixos_image);
              nixos_sprite.SetX(Window.GetX() + (Window.GetWidth() / 2 - nixos_image.GetWidth() / 2)); # Center the image horizontally
              nixos_sprite.SetY(Window.GetHeight() - nixos_image.GetHeight() - 100); # Display just above the bottom of the screen
              " >> $out/share/plymouth/themes/${config.boot.plymouth.theme}/${config.boot.plymouth.theme}.script
            '';
        });
      })
    ];
  };
}
