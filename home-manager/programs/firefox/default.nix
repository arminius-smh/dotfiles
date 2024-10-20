{
  inputs,
  config,
  pkgs,
  ...
}:
{
  programs = {
    firefox = {
      enable = true;
      policies = {
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DontCheckDefaultBrowser = true;
        PasswordManagerEnabled = false;
        ExtensionSettings = {
          "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}" = {
            install_url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_mocha_mauve.xpi";
            installation_mode = "force_installed";
          };
        };
      };
      profiles = {
        armin = {
          isDefault = true;
          containersForce = true;
          containers = {
            T = {
              color = "red";
              icon = "tree";
              id = 1;
            };
          };
          extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
            # bypass-paywalls-clean
            bitwarden
            catppuccin-gh-file-explorer
            darkreader
            refined-github
            multi-account-containers
            return-youtube-dislikes
            seventv
            simple-translate
            simplelogin
            sponsorblock
            startpage-private-search
            stylus
            torrent-control
            ublock-origin
            user-agent-string-switcher
            videospeed
            violentmonkey
            yomitan
            zotero-connector
          ];
          bookmarks = [
            {
              name = "toolbar";
              toolbar = true;
              bookmarks = [
                {
                  name = "Homepage";
                  url = config.secrets.ip.homepage;
                }
                {
                  name = "Syncthing";
                  url = "http://localhost:8384/";
                }
                {
                  name = "Palette";
                  url = "https://catppuccin.com/palette";
                }
                {
                  name = "aesthetic";
                  bookmarks = [
                    {
                      name = "lily_chou-chou";
                      url = "http://lily-chou-chou.jp/holic/bbs/";
                    }
                    {
                      name = "lain";
                      url = "https://fauux.neocities.org/";
                    }
                  ];
                }
                config.secrets.bookmarks.priv
              ];
            }
          ];
          settings = {
            browser = {
              aboutConfig = {
                showWarning = false;
              };
              startup = {
                page = 3;
                homepage = config.secrets.ip.homepage;
              };
              newtabpage = {
                activity-stream = {
                  showSponsoredTopSites = false;
                  feeds = {
                    topsites = false;
                  };
                };
              };
            };
            app = {
              normandy = {
                first_run = false;
              };
            };
            signon = {
              rememberSignons = false;
            };
            extensions = {
              update = {
                enabled = false;
              };
            };
          };
        };
        # only for kiosk twitch chat
        twitch = {
          isDefault = false;
          id = 1;
          extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
            seventv
            stylus
          ];
        };
      };
    };
  };
}
