{ config, inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ../../private

    ../../home-manager
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";

    cursors = {
      enable = true;
      flavor = "macchiato";
      accent = "dark";
    };
  };

  home = {
    username = "armin";
    homeDirectory = "/home/armin";
    stateVersion = "24.05";

    pointerCursor = {
      size = 24;
      gtk.enable = true;
      hyprcursor.enable = true;
    };

    sessionVariables = {
      MONITOR_PRIMARY = "eDP-1";
      MONITOR_SECONDARY = "";
      MONITOR_TERTIARY = "";
    };
  };

  cave = {
    wayland.windowmanager.hyprland.enable = true;
    gtk.enable = true;
    qt.enable = true;
    xdg.enable = true;
    systemd = {
      enable = true;
      services = {
        clear-trash.enable = true;
        battery-alert.enable = true;
        vesktop.enable = true;
        telegram.enable = true;
        joplin-desktop.enable = true;
        waypaper = {
          enable = true;
          cmd = "--restore";
        };
        hypr_handle_events.enable = true;
        nwg-dock-hyprland.enable = true;
        quickshell.enable = true;
        thunderbird.enable = true;
      };
    };
    services = {
      syncthing.enable = true;
      network-manager-applet.enable = true;
      hyprpolkitagent.enable = true;
      swayosd.enable = true;
      swaync.enable = true;
      hypridle.enable = true;
    };
    programs = {
      collections = {
        coding.enable = true;
      };
      zsh.enable = true;
      firefox.enable = true;
      zathura.enable = true;
      vlc.enable = true;
      ssh.enable = true;
      kitty = {
        enable = true;
        fontSize = 11;
      };
      rofi.enable = true;
      cava.enable = true;
      starship.enable = true;
      btop.enable = true;
      anki.enable = true;
      neovim.enable = true;
      fastfetch = {
        enable = true;
        hostname = "дискавери";
      };
      bat.enable = true;
      delta.enable = true;
      direnv.enable = true;
      vesktop.enable = true;
      eza.enable = true;
      feh.enable = true;
      git.enable = true;
      imv.enable = true;
      lazygit.enable = true;
      mpv.enable = true;
      obs-studio.enable = true;
      thunderbird.enable = true;
      nwg-displays.enable = true;
      libinput-gestures.enable = true;
      nwg-dock-hyprland.enable = true;
      waypaper.enable = true;
      hyprlock.enable = true;
      quickshell.enable = true;
    };
  };

  xdg = {
    configFile = {
      "uwsm/env" = {
        text = ''
          . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
        '';
      };
    };
  };
}
