{pkgs, ...}: let
  # WAIT: https://github.com/catppuccin/fcitx5/pull/4 + nix pr
  catppuccin-fcitx5-git = pkgs.catppuccin-fcitx5.overrideAttrs (prev: {
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "arminius-smh";
      repo = "fcitx5";
      rev = "19e82ba04e1597c41d47ad2cf6e462e56a003e0e"; # latest commit
      sha256 = "sha256-pSVGoWehLGCWfUf5vAwBR9cvAHBaFQwag5x+OQkCPEs="; # rebuild first, then exchange with real hash
    };
  });
in {
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-lua

          catppuccin-fcitx5-git
        ];
        # settings = {
        #   inputMethod = {
        #     "Groups/0" = {
        #       Name = "Default";
        #       "Default Layout" = "keyboard-de-deadtilde";
        #       DefaultIM = "mozc";
        #     };
        #     "Groups/0/Items/0" = {
        #       Name = "keyboard-de-deadtilde";
        #       Layout = "";
        #     };
        #     "Groups/0/Items/1" = {
        #       Name = "mozc";
        #       Layout = "";
        #     };
        #
        #     "GroupOrder" = {
        #       "0" = "Default";
        #     };
        #   };
        # };
      };
    };
  };
}
