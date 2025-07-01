{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    browsers.zen.enable = lib.mkEnableOption "Enable and configure Zen";
  };

  config = lib.mkIf config.browsers.zen.enable {
    programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        # find more options here: https://mozilla.github.io/policy-templates/
      };
      # preferences = {
      #   # show hex form for theme editor
      #   "zen.theme.gradient.show-custom-colors" = true;
      # };
      # profiles.bdface = {
      #   search.default = "ddg";
      #   extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #     ublock-origin
      #     onepassword-password-manager
      #     # proton-pass #maybe
      #     enhancer-for-youtube
      #     sponsorblock
      #     youtube-shorts-block
      #     return-youtube-dislikes
      #     betterttv
      #     styl-us
      #     user-agent-string-switcher
      #     docsafterdark
      #   ];
      # };
    };
  };
}
