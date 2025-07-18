{ ... }:
{
  services = {
    swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "top";
        "control-center-margin-top" = 10;
        "control-center-margin-bottom" = 0;
        "control-center-margin-right" = 10;
        "control-center-margin-left" = 0;
        "notification-icon-size" = 64;
        "notification-body-image-height" = 100;
        "notification-body-image-width" = 200;
        "cssPriority" = "user";
        timeout = 10;
        "timeout-low" = 5;
        "timeout-critical" = 0;
        "fit-to-screen" = false;
        "control-center-width" = 500;
        "control-center-height" = 600;
        "notification-window-width" = 500;
        "keyboard-shortcuts" = true;
        "image-visibility" = "when-available";
        "transition-time" = 200;
        "hide-on-clear" = false;
        "hide-on-action" = true;
        "script-fail-notify" = true;
        "notification-visibility" = {
          "hide-spotify-from-cc" = {
            state = "transient";
            "app-name" = "Spotify";
          };
          "hide-spotify_player-from-cc" = {
            state = "transient";
            "app-name" = "spotify_player";
          };
          "hide-heroic-from-cc" = {
            state = "transient";
            "app-name" = "heroic";
          };
        };
        widgets = [
          "title"
          "dnd"
          "mpris"
          "notifications"
        ];
        "widget-config" = {
          title = {
            text = "Notifications";
            "clear-all-button" = true;
            "button-text" = "Clear All";
          };
          dnd = {
            text = "Do Not Disturb";
          };
          mpris = {
            "image-size" = 96;
            "image-radius" = 12;
          };
          volume = {
            label = "";
          };
        };
      };
      style = ''
        @define-color noti-border-color rgba(255, 255, 255, 0.15);
        @define-color noti-bg #2E3440;
        @define-color noti-bg-alt #383E4A;
        @define-color noti-bg-alt-alpha rgba(56, 62, 75, 0.95);
        @define-color noti-fg #E5E9F0;
        @define-color noti-bg-hover #81A1C1;
        @define-color noti-bg-focus #383E4A;
        @define-color noti-close-bg rgba(255, 255, 255, 0.1);
        @define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);
        @define-color noti-urgent #BF616A;

        @define-color bg-selected rgb(0, 128, 255);

        * {
            color: @noti-fg;
        }

        .notification {
            border-radius: 12px;
            margin: 6px 12px;
            box-shadow:
                0 0 0 1px rgba(0, 0, 0, 0.3),
                0 1px 3px 1px rgba(0, 0, 0, 0.7),
                0 2px 6px 2px rgba(0, 0, 0, 0.3);
            padding: 0;
        }

        .critical {
            background: @noti-urgent;
            padding: 2px;
            border-radius: 12px;
        }

        .notification-content {
            background: transparent;
            padding: 6px;
            border-radius: 12px;
            border: none;
        }

        .close-button {
            background: @noti-close-bg;
            color: white;
            text-shadow: none;
            padding: 0;
            border-radius: 100%;
            margin-top: 10px;
            margin-right: 16px;
            box-shadow: none;
            border: none;
            min-width: 24px;
            min-height: 24px;
        }

        .close-button:hover {
            box-shadow: none;
            background: @noti-close-bg-hover;
            transition: all 0.15s ease-in-out;
            border: none;
        }

        .notification-default-action {
            padding: 4px;
            margin: 0;
            box-shadow: none;
            background: @noti-bg;
            border-bottom: none;
            color: white;
        }

        .notification-action {
            padding: 4px;
            margin: 0;
            box-shadow: none;
            background: none;
            border: none;
            color: white;
        }

        .notification-alt-actions {
            background: @noti-bg;
            border: none;
            box-shadow: none;
        }

        .notification-alt-actions button {
            background: @noti-bg-alt;
        }

        .notification-alt-actions button:hover {
            background: @noti-bg-hover;
        }

        .notification-default-action:hover {
            -gtk-icon-effect: none;
            background: @noti-bg-hover;
        }

        .notification-default-action {
            border-radius: 12px;
        }

        /* When alternative actions are visible */
        .notification-default-action:not(:only-child) {
            border-bottom-left-radius: 0px;
            border-bottom-right-radius: 0px;
            border-bottom: 1px solid @noti-border-color;
        }

        /* add bottom border radius to eliminate clipping */
        .notification-action:first-child {
            border-bottom-left-radius: 10px;
        }

        .notification-action:last-child {
            border-bottom-right-radius: 10px;
            /* border-right: 1px solid @noti-border-color; */
        }

        .image {
        }

        .body-image {
            margin-top: 6px;
            background-color: white;
            border-radius: 12px;
        }

        .summary {
            font-size: 16px;
            font-weight: bold;
            background: transparent;
            color: white;
            text-shadow: none;
        }

        .time {
            font-size: 16px;
            font-weight: bold;
            background: transparent;
            color: white;
            text-shadow: none;
            margin-right: 18px;
        }

        .body {
            font-size: 15px;
            font-weight: normal;
            background: transparent;
            color: white;
            text-shadow: none;
        }

        /* The "Notifications" and "Do Not Disturb" text widget */
        .top-action-title {
            color: white;
            text-shadow: none;
        }

        .control-center {
            background: @noti-bg-alt-alpha;
            border-radius: 10px;
            background-clip: border-box;
            padding: 4px;
            box-shadow:
                0 0 0 1px rgba(0, 0, 0, 0.3),
                0 1px 3px 1px rgba(0, 0, 0, 0.7),
                0 2px 6px 2px rgba(0, 0, 0, 0.3);
            color: @noti-bg-alt;
            border: 2px solid @noti-bg-hover;
        }

        .control-center-list {
            background: transparent;
        }

        .floating-notifications {
            background: transparent;
        }

        /* Window behind control center and on all other monitors */
        .blank-window {
            background: transparent;
        }

        /*** Widgets ***/

        /* Title widget */
        .widget-title {
            margin: 8px;
            font-size: 1.5rem;
        }

        .widget-title > button {
            font-size: initial;
            color: white;
            text-shadow: none;
            background: @noti-bg;
            border: 1px solid @noti-border-color;
            box-shadow: none;
            border-radius: 12px;
        }

        .widget-title > button:hover {
            background: @noti-bg-hover;
        }

        /* DND widget */
        .widget-dnd {
            margin: 8px;
            font-size: 1.1rem;
        }

        .widget-dnd > switch {
            font-size: initial;
            border-radius: 12px;
            background: @noti-bg;
            border: 1px solid @noti-border-color;
            box-shadow: none;
        }

        .widget-dnd > switch:checked {
            background: @bg-selected;
        }

        .widget-dnd > switch slider {
            background: @noti-bg-hover;
            border-radius: 12px;
        }

        /* Mpris widget */
        .widget-mpris {
            /* The parent to all players */
        }

        .widget-mpris-player {
            padding: 8px;
            margin: 8px;
        }

        .widget-mpris-title {
            font-weight: bold;
            font-size: 1.25rem;
        }

        .widget-mpris-subtitle {
            font-size: 1.1rem;
        }
      '';
    };
  };
}
