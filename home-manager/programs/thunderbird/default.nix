{ config, pkgs, ... }:
{
  programs = {
    thunderbird = {
      enable = true;
      package = pkgs.thunderbird.override {
        # https://github.com/nix-community/home-manager/issues/5654
        extraPolicies = {
          ExtensionSettings = {
            "{47f5c9df-1d03-5424-ae9e-0613b69a9d2f}" = {
              install_url = "https://github.com/catppuccin/thunderbird/raw/refs/heads/main/themes/mocha/mocha-mauve.xpi";
              installation_mode = "force_installed";
            };
          };
        };
      };

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
