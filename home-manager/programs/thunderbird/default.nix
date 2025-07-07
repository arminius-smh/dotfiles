{ config, ... }:
{
  catppuccin = {
    thunderbird = {
      enable = true;
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
        ${config.secrets.mail.personal} = {
          thunderbird = {
            enable = true;
            profiles = [ "armin" ];
          };
          primary = true;
          realName = config.secrets.fullName;
          address = config.secrets.mail.personal;
          userName = config.secrets.mail.personal;
          imap = {
            host = "imap.ionos.de";
            port = 993;
          };
          smtp = {
            host = "smtp.ionos.de";
            port = 465;
          };
        };
        ${config.secrets.mail.university} = {
          thunderbird = {
            enable = true;
            profiles = [ "armin" ];
          };
          realName = config.secrets.fullName;
          address = config.secrets.mail.university;
          userName = "${config.secrets.userNames.university}@tu-berlin.de";
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
}
