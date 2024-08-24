{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/disk/by-id/ata-SPCC_Solid_State_Disk_AAAA0000000000005478";
        useOSProber = false;
      };
    };
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = ["nohibernate"];
    supportedFilesystems = ["zfs"];
    zfs = {
      forceImportRoot = false;
      extraPools = ["tank"];
    };
  };
  virtualisation = {
    docker = {
      enable = true;
    };
  };

  networking = {
    hostName = "excelsior";
    hostId = "235f276f";
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = false;
    };
  };

  # Set your time zone.
  time = {
    timeZone = "Europe/Berlin";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  console = {
    keyMap = "de";
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      armin = {
        isNormalUser = true;
        description = "armin";
        extraGroups = ["networkmanager" "wheel" "docker"];
      };
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      zfs
      git
    ];
  };

  programs = {
    zsh = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  services = {
    zfs = {
      autoScrub = {
        enable = true;
        pools = [
          "tank"
        ];
        interval = "Mon, 04:00";
      };
    };
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
      };
    };
    xserver = {
      layout = "de";
      xkbVariant = "";
    };
  };

  system = {
    stateVersion = "23.11";
  };
}
