{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.spicetify.homeManagerModules.default
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
    stateVersion = "24.11";

    pointerCursor = {
      size = 24;
      gtk.enable = true;
      hyprcursor.enable = true;
    };

    packages = with pkgs; [
      ripgrep
      fd
      gtrash
      jq
      chromium
      libnotify
      file-roller
      jellyfin-desktop
      feishin
      ffmpeg
      tree
      droidcam
    ];

    sessionVariables = {
      MONITOR_PRIMARY = "HDMI-A-1";
      MONITOR_SECONDARY = "DP-2";
      MONITOR_TERTIARY = "DP-3";
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
        feishin.enable = true;
        clear-trash.enable = true;
        discord.enable = true;
        telegram.enable = true;
        joplin-desktop.enable = true;
        steam.enable = true;
        heroic.enable = true;
        waypaper.enable = true;
        hypr_handle_events.enable = true;
        nwg-dock-hyprland.enable = true;
        quickshell.enable = true;
        solaar.enable = true;
        thunderbird.enable = true;
        spotify.enable = true;
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
        gaming = {
          enable = true;
          minecraft.enable = true;
          emulation = {
            enable = true;
            nes = true;
            snes = true;
            gb = true;
            n64 = true;
            gc_wii = true;
            nds = true;
            "3ds" = true;
            wiiu = true;
            switch = true;
            ps1 = true;
            ps2 = true;
          };
        };
      };
      zathura.enable = true;
      neovim.enable = true;
      firefox.enable = true;
      ssh.enable = true;
      kitty.enable = true;
      vlc.enable = true;
      zsh.enable = true;
      rofi.enable = true;
      cava.enable = true;
      anki.enable = true;
      bat.enable = true;
      delta.enable = true;
      starship.enable = true;
      discord.enable = true;
      direnv.enable = true;
      feh.enable = true;
      eza.enable = true;
      git.enable = true;
      spotify.enable = true;
      lazygit.enable = true;
      btop = {
        enable = true;
        package = pkgs.btop.override { rocmSupport = true; };
      };
      fastfetch = {
        enable = true;
        hostname = "феникс";
      };
      imv.enable = true;
      mpv.enable = true;
      obs-studio.enable = true;
      thunderbird.enable = true;
      trezor-suite.enable = true;
      heroic.enable = true;
      mangohud.enable = true;
      nwg-displays.enable = true;
      nwg-dock-hyprland.enable = true;
      thunar.enable = true;
      waypaper.enable = true;
      hyprlock.enable = true;
      quickshell.enable = true;
    };
  };

  # idk where to put
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
