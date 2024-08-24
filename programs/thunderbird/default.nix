{config, ...}: {
  programs = {
    thunderbird = {
      enable = true;
      profiles = {
        armin = {
          isDefault = true;
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
            profiles = ["armin"];
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
            profiles = ["armin"];
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
