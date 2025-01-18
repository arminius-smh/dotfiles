{ pkgs, lib, ... }:
{
  home = {
    packages = with pkgs; [
      heroic
    ];

    activation = {
      # this is stupid.
      heroic-settings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! $(${pkgs.jq}/bin/jq '.defaultSettings.customThemesPath' /home/armin/.config/heroic/config.json) == '"/home/armin/Collections/heroic/themes"' ]; then
          ${pkgs.jq}/bin/jq '.defaultSettings.customThemesPath = "/home/armin/Collections/heroic/themes"' /home/armin/.config/heroic/config.json > /tmp/temp.json
          mv /tmp/temp.json /home/armin/.config/heroic/config.json
        fi

        if [ ! $(${pkgs.jq}/bin/jq '.theme' /home/armin/.config/heroic/store/config.json) == '"catppuccin-mocha.css"' ]; then
          ${pkgs.jq}/bin/jq '.theme = "catppuccin-mocha.css"' /home/armin/.config/heroic/store/config.json > /tmp/temp.json
          mv /tmp/temp.json /home/armin/.config/heroic/store/config.json
        fi
      '';
    };
  };
}
