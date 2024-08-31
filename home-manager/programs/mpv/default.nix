{pkgs, ...}: {
  programs = {
    mpv = {
      enable = true;
      catppuccin = {
        enable = true;
      };
      config = {
        screenshot-format = "png";
        # Save screenshots in the pattern of 'filename-timestamp.png'
        screenshot-template = "%F-%p";
        # Deactivate debanding
        "--deband" = "no";
      };
      bindings = {
        "ctrl+t" = "script-binding toggle-subs-to-clipboard";

        "B" = "script_message bookmarker-menu";
        "b" = "script_message bookmarker-quick-save";
        "ctrl+b" = "script_message bookmarker-quick-load";
        "r" = "cycle_values video-rotate 90 180 270 0";
      };
      scripts = [
        (pkgs.callPackage ../../../assets/packages/mpv-scripts/subs_to_clipboard {})
        (pkgs.callPackage ../../../assets/packages/mpv-scripts/bookmarker-menu {})
      ];
    };
  };
}
