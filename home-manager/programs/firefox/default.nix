{
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
      };
      profiles = {
        armin = {
          isDefault = true;
          containersForce = true;
          containers = {
            private = {
              color = "blue";
              icon = "fingerprint";
              id = 1;
            };
            university = {
              color = "purple";
              icon = "briefcase";
              id = 2;
            };
          };
          search = {
            default = "ddg";
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
            settings = {
            }
            // config.secrets.firefox.extensions.settings;
            packages = with pkgs.firefox-addons; [
              bitwarden
              catppuccin-web-file-icons
              firefox-color
              frankerfacez
              return-youtube-dislikes
              simple-translate
              torrent-control
              ublock-origin
              violentmonkey
              yomitan
              pkgs.firefox-addons."2fas-two-factor-authentication"
            ];
          };
          bookmarks = {
            force = true;
            settings = [
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
                    url = "http://localhost:8384";
                  }
                  {
                    name = "HLTV";
                    url = "https://hltv.org";
                  }
                  {
                    name = "Palette";
                    url = "https://catppuccin.com/palette";
                  }
                  {
                    name = "TU Berlin";
                    bookmarks = [
                      {
                        name = "ISIS";
                        url = "https://isis.tu-berlin.de/";
                      }
                      {
                        name = "Moses";
                        url = "https://moseskonto.tu-berlin.de";
                      }
                    ];
                  }
                  {
                    name = "Logged";
                    bookmarks = [
                      {
                        name = "Letterboxd";
                        url = "https://letterboxd.com/";
                      }
                      {
                        name = "Goodreads";
                        url = "https://www.goodreads.com/";
                      }
                      {
                        name = "Serializd";
                        url = "https://www.serializd.com/";
                      }
                      {
                        name = "HowLongToBeat";
                        url = "https://howlongtobeat.com/";
                      }
                    ];
                  }
                  {
                    name = "aesthetic";
                    bookmarks = [
                      {
                        name = "lily_chou-chou";
                        url = "http://lily-chou-chou.jp/holic/bbs";
                      }
                      {
                        name = "lain";
                        url = "https://fauux.neocities.org";
                      }
                      {
                        name = "julian_glander";
                        url = "https://glander.co";
                      }
                      {
                        name = "elora_pautrat";
                        url = "https://www.elorapautrat.com";
                      }
                    ];
                  }
                  config.secrets.bookmarks.priv
                ];
              }
            ];
          };
          userContent = ''
            @-moz-document url("about:home"), url("about:newtab") {
                :root {
                    --newtab-text-primary-color: #cad3f5 !important;
                    --newtab-background-color-secondary: #24273a !important;
                }
                body {
                    --newtab-wallpaper: url("https://i.imgur.com/o1ERpAl.jpeg") !important;
                }
            }
          '';
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

            "privacy.history.custom" = true;

            "browser.aboutConfig.showWarning" = false;
            "browser.formfill.enable" = false;
            "browser.startup.page" = 3;
            "browser.startup.homepage" = config.secrets.ip.homepage;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = true;
            "browser.storageManager.pressureNotification.usageThresholdGB" = 10;
            "browser.translations.neverTranslateLanguages" = "de";
            "browser.newtabpage.pinned" =
              ''[{"url":"https://letterboxd.com/","label":"Letterboxd","baseDomain":"letterboxd.com"},{"url":"https://www.goodreads.com/","label":"Goodreads"},{"url":"https://www.serializd.com/","label":"Serializd"},{"url":"https://howlongtobeat.com/","label":"HowLongToBeat"}]'';

            "app.normandy.first_run" = false;

            "extensions.update.enabled" = false;
            "extensions.autoDisableScopes" = 0;

            "media.eme.enabled" = true;
            "extensions.webextensions.ExtensionStorageIDB.enabled" = false;
          };

          # // lib.optionalAttrs (systemName == "discovery") {
          #   "general.useragent.override" =
          #     "Mozilla/5.0 (X11; CrOS aarch64 15236.80.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.5414.125 Safari/537.36"; # Netflix, pls...
          # };
        };
      };
    };
  };
}
