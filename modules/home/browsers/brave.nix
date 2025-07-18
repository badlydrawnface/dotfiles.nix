{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    browsers.brave.enable = lib.mkEnableOption "Enable and configure Brave";
  };

  config = lib.mkIf config.browsers.brave.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # proton pass
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # sponsorblock
        { id = "gebbhagfogifgggkldgodflihgfeippi"; } # returnyoutubedislike
        { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # enhancer for youtube
      ];
    };
    catppuccin.chromium.enable = true;
  };
}
