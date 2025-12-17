{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.cave.programs.mpv;
in
{
  options.cave = {
    programs.mpv.enable = lib.mkEnableOption "enable programs.mpv config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      mpv = {
        enable = true;
        config = {
          profile = "high-quality";
          alang = "ja,jp,jpn,en,eng,de,deu,ger";
          slang = "en,eng,de,deu,ger";
          sub-auto = "fuzzy";
          blend-subtitles = "yes";
          audio-file-auto = "fuzzy";
          dither-depth = "auto";
          fullscreen = "yes";
          screenshot-format = "png";
          screenshot-template = "%F-%p";
          screenshot-png-compression = 3;
          deband = "yes";
          deband-iterations = 4;
          deband-threshold = 48;
          deband-range = 24;
        };
        scriptOpts = {
          modernz = {
            window_top_bar = "no";
            showonpause = "no";
            osc_on_start = "yes";
            seekbarfg_color = "#FFFFFF";
            seekbarbg_color = "#FFFFFF";
            hover_effect_color = "#FFFFFF";
            ontop_button = "no";
            speed_button = "yes";
          };
        };
        bindings = {
          "ctrl+t" = "script-binding toggle-subs-to-clipboard";
          "B" = "script_message bookmarker-menu";
          "b" = "script_message bookmarker-quick-save";
          "ctrl+b" = "script_message bookmarker-quick-load";
          "r" = "cycle_values video-rotate 90 180 270 0";
        };
        scripts = with pkgs; [
          mpvScripts.modernz
          mpvScripts.thumbfast
          # bookmarker-menu
          # subs_to_clipboard
        ];
      };
    };
  };
}
