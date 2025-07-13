{ config, lib, ... }:
{
  options = {
    browsers.brave.enable = lib.mkEnableOption "Enable and configure Brave/Chromium";
  };

  config = lib.mkIf config.browsers.brave.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
        "gebbhagfogifgggkldgodflihgfeippi" # returnyoutubedislike
        "ponfpcnoihfmfllpaingbgckeeldkhle" # enhancer for youtube
      ];
    };
  };
}
