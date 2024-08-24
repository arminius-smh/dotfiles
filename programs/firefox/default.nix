{pkgs, ...}: {
  programs = {
    firefox = {
      enable = true;
      profiles = {
        armin = {
          isDefault = true;
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            # bypass-paywalls-clean
            bitwarden
            return-youtube-dislikes
            seventv
            simple-translate
            simplelogin
            sponsorblock
            startpage-private-search
            stylus
            ublock-origin
            videospeed
            violentmonkey
            yomitan
            zotero-connector
          ];
          bookmarks = [
            {
              name = "Homepage";
              toolbar = true;
              bookmarks = [
                {
                  name = "Homepage";
                  url = "http://192.168.16.10:3002/";
                }
                {
                  name = "Syncthing";
                  url = "http://localhost:8384/";
                }
                {
                  name = "Gaming Releases";
                  url = "https://www.releases.com/hot/games_pc";
                }
              ];
            }
          ];
          settings = {
            "app.normandy.first_run" = false;
            "browser.aboutConfig.showWarning" = false;
            "signon.rememberSignons" = false;
            "browser.startup.page" = 3;
            "browser.startup.homepage" = "http://192.168.16.10:3002";
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "extensions.update.enabled" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            # NOTE: browser.uiCustomization.state includes import-bookmark from the toolbar, however changing it barely doable (with external script)
          };
        };
      };
    };
  };
}
