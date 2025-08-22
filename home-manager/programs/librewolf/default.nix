{
  inputs,
  config,
  pkgs,
  ...
}:
let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  programs = {
    librewolf = {
      enable = true;
      profiles = {
        armin = {
          isDefault = true;
          search = {
            default = "ddg";
            force = true;
            engines = {
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
            packages = with addons; [
              bitwarden
              firefox-color
              return-youtube-dislikes
              seventv
              simple-translate
              violentmonkey
              yomitan

              addons."2fas-two-factor-authentication"
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

            "browser.startup.page" = 3;
            "browser.startup.homepage" = config.secrets.ip.homepage;
          };
        };
      };
    };
  };
}
