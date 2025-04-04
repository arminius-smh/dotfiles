{ ... }:
{
  programs = {
    waybar = {
      style =
        # css
        ''
          * {
              border: none;
              border-radius: 0;
              font-family: Nerd Font Hack;
              font-size: 12px;
          }

          window#waybar {
              background: rgba(0, 0, 0, 0.5);
          }

          #workspaces {
              margin-top: 6px;
              margin-left: 12px;
              margin-bottom: 6px;
              border-radius: 26px;
              background: @surface0;
              transition: none;
          }

          #mpris {
              margin: 6px 6px 6px 12px;
              background: alpha(@mauve, 0.5);
              padding: 0 10px;
              border-radius: 8px;
              color: #f5f0ff;
          }

          #custom-launcher {
              margin-top: 6px;
              margin-left: 12px;
              margin-bottom: 6px;
              padding-left: 12px;
              padding-right: 12px;
              background-color: @mauve;
              color: @surface0;
              border-radius: 10px;
          }

          #workspaces button {
              transition: none;
              color: @rosewater;
              background: transparent;
              font-size: 16px;
          }

          #workspaces button.focused, #workspaces button.active {
              color: @sky;
          }

          #workspaces button:hover {
              transition: none;
              box-shadow: inherit;
              text-shadow: inherit;
              color: @pink;
          }

          #custom-notification {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 16px;
              padding-right: 16px;
              margin-bottom: 6px;
              border-radius: 26px;
              transition: none;
              color: @surface1;
              background: @peach;
          }

          #battery {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 16px;
              padding-right: 16px;
              margin-bottom: 6px;
              border-radius: 26px;
              transition: none;
              color: @surface0;
              background: @mauve;
          }

          #network {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 16px;
              padding-right: 16px;
              margin-bottom: 6px;
              border-radius: 26px;
              transition: none;
              color: @surface0;
              background: @mauve;
          }

          #pulseaudio {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 16px;
              padding-right: 16px;
              margin-bottom: 6px;
              border-radius: 26px;
              transition: none;
              color: @surface0;
              background: @blue;
          }

          #cpu {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 16px;
              padding-right: 16px;
              margin-bottom: 6px;
              border-radius: 26px;
              transition: none;
              color: @surface0;
              background: @lavender;
          }

          #memory {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 16px;
              padding-right: 16px;
              margin-bottom: 6px;
              border-radius: 26px;
              transition: none;
              color: @surface0;
              background: @red;
          }

          #backlight {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 16px;
              padding-right: 16px;
              margin-bottom: 6px;
              border-radius: 26px;
              transition: none;
              color: @surface0;
              background: @red;
          }

          #clock {
              margin-top: 6px;
              margin-left: 8px;
              margin-right: 12px;
              padding-left: 16px;
              padding-right: 16px;
              margin-bottom: 6px;
              border-radius: 26px;
              transition: none;
              color: @rosewater;
              background: @surface0;
          }
        '';
    };
  };
}
