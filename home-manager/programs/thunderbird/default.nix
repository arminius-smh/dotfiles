{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.thunderbird;
in
{
  options.cave = {
    programs.thunderbird.enable = lib.mkEnableOption "enable programs.thunderbird config";
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      thunderbird = {
        enable = true;
        profile = "armin";
      };
    };

    programs = {
      thunderbird = {
        enable = true;

        settings = {
          mailnews = {
            start_page = {
              enabled = false;
            };
          };
          toolkit = {
            legacyUserProfileCustomizations = {
              stylesheets = true;
            };
          };
        };

        profiles = {
          armin = {
            isDefault = true;
            settings = {
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

              "mailnews.default_sort_order" = 1;
              "mail.biff.play_sound" = false;
              "intl.regional_prefs.use_os_locales" = true; # Date and Time Formatting: Regional settings locale
            };
            userChrome = ''
              * {
                --lwt-text-color: #cdd6f4 !important; /* catppuccin-mocha text color */
              }
            '';
            userContent = ''
              /* settings page catppuccin-mocha */
              @-moz-document url-prefix("about:") {
                  #pref-category-box,
                  #sidebar,
                  #accountTreeBox {
                      background-color: #1e1e2e !important;
                  }

                  #preferencesContainer,
                  .sticky-container,
                  #content,
                  .main-heading,
                  .main-search {
                      background-color: #181825 !important;
                  }

                  #searchInput,
                  search-textbox {
                      background-color: #1e1e2e !important;
                  }

                  .card {
                      background-color: #1e1e2e !important;
                  }
              }
            '';
          };
        };
      };
    };

    accounts = {
      email = {
        accounts = {
          ${config.private.mail.personal} = {
            thunderbird = {
              enable = true;
              profiles = [ "armin" ];
            };
            primary = true;
            realName = config.private.usernames.fullname;
            address = config.private.mail.personal;
            userName = config.private.mail.personal;
            imap = {
              host = "imap.ionos.de";
              port = 993;
            };
            smtp = {
              host = "smtp.ionos.de";
              port = 465;
            };
          };
          ${config.private.mail.university} = {
            thunderbird = {
              enable = true;
              profiles = [ "armin" ];
            };
            realName = config.private.usernames.fullname;
            address = config.private.mail.university;
            userName = "${config.private.usernames.university}@tu-berlin.de";
            imap = {
              host = "mail.tu-berlin.de";
              port = 993;
            };
            smtp = {
              host = "mail.tu-berlin.de";
              port = 587;
              tls = {
                useStartTls = true;
              };
            };
          };
        };
      };
    };
  };
}
