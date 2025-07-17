{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    wmCommon.dunst.enable = lib.mkEnableOption {
      default = true;
      description = "Enable dunst";
    };
  };

  config = lib.mkIf config.wmCommon.dunst.enable {
    # notifications
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "Papirus-dark";
        package = pkgs.catppuccin-papirus-folders;
        size = "32x32";
      };
      settings = {
        global = {
          font = "Adwaita Sans 11";
        };
      };
    };
  };
}
