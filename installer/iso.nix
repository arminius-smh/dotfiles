# WIP
{ pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  console = {
    useXkbConfig = true;
  };

  services = {
    xserver = {
      xkb = {
        layout = "de";
        variant = "deadtilde";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      git
      neovim
    ];

    etc = {
      "ssh/git" = {
        source = ../private/files/git;
        user = "nixos";
        group = "users";
      };
    };
  };

  security = {
    pki = {
      certificateFiles = [ ../private/files/cave_root_ca.crt ];
    };
  };

  programs = {
    git = {
      enable = true;
      lfs = {
        enable = true;
      };
      config = {
        safe = {
          directory = "*";
        };
      };
    };

    ssh = {
      extraConfig = ''
        Host git.cave.home.arpa
          hostname git.cave.home.arpa
          identitiesOnly yes
          identityFile /etc/ssh/git
          port 222
          user git
      '';
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      warn-dirty = false;
    };
  };
}
