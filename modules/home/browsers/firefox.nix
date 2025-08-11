{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options = {
    browsers.firefox.enable = lib.mkEnableOption "Enable and configure Firefox web browser";
  };

  config = lib.mkIf config.browsers.firefox.enable {
    # temporary
    catppuccin.firefox.enable = false;
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
      };
      profiles.default = {
        isDefault = true;
        extensions = with pkgs.firefox-addons; [
          ublock-origin
          https-everywhere
          decentraleyes
          sponsorblock
        ];
        search = {
          force = true;
          default = "kagi";
          privateDefault = "ddg";
          order = [
            "kagi"
            "ddg"
            "google"
          ];
          engines = {
            kagi = {
              name = "Kagi";
              urls = [ { template = "https://kagi.com/search?q={searchTerms}"; } ];
              icon = "https://kagi.com/favicon.ico";
            };
            bing.metaData.hidden = true;
          };
        };
        settings = {
          "browser.startup.homepage" = "about:home";

          # Disable irritating first-run stuff
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.feeds.showFirstRunUI" = false;
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "browser.rights.3.shown" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.uitour.enabled" = false;
          "startup.homepage_override_url" = "";
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.bookmarks.addedImportButton" = true;
        };
      };
    };
  };
}
