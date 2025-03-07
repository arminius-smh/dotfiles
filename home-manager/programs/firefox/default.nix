{
  inputs,
  systemName,
  config,
  pkgs,
  lib,
  ...
}:
let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
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
          # own fork of videospeed with local storage
          "{d559f111-ba90-4646-8d28-5e8a3da53fe9}" = {
            install_url = "https://github.com/arminius-smh/videospeed/releases/download/release/video_speed_controller.xpi";
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
          search = {
            default = "DuckDuckGo";
            force = true;
            engines = {
              "Startpage" = {
                definedAliases = [ "@sp" ];
                urls = [
                  {
                    template = "https://www.startpage.com/do/dsearch";
                    params = [
                      {
                        # settings
                        name = "prfe";
                        value = config.secrets.settings.startpage;
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "NixOS options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@no" ];
              };
              "home-manager options" = {
                urls = [
                  {
                    template = "https://home-manager-options.extranix.com/?release=master";
                    params = [
                      {
                        name = "release";
                        value = "master";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@hm" ];
              };
            };
          };
          extensions = {
            force = true;
            settings =
              {
                "{d559f111-ba90-4646-8d28-5e8a3da53fe9}" = {
                  settings = import ./config/videospeed.nix;
                };
              }
              // config.secrets.firefox.extensions.settings
              // lib.optionalAttrs (systemName == "discovery") {
                "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
                  settings = import ./config/user-agent-switcher.nix;
                };
              };
            packages = with addons; [
              bitwarden
              catppuccin-gh-file-explorer
              refined-github
              multi-account-containers
              return-youtube-dislikes
              seventv
              simple-translate
              simplelogin
              sponsorblock
              stylus
              torrent-control
              ublock-origin
              user-agent-string-switcher
              violentmonkey
              yomitan
              zotero-connector

              addons."2fas-two-factor-authentication"
            ];
          };
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
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

            "privacy.history.custom" = true;

            "browser.aboutConfig.showWarning" = false;
            "browser.formfill.enable" = false;
            "browser.startup.page" = 3;
            "browser.startup.homepage" = config.secrets.ip.homepage;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;

            "app.normandy.first_run" = false;

            "extensions.update.enabled" = false;
            "extensions.autoDisableScopes" = 0;

            "media.eme.enabled" = true;
            "extensions.webextensions.ExtensionStorageIDB.enabled" = false;
          };
        };
      };
    };
  };
}
