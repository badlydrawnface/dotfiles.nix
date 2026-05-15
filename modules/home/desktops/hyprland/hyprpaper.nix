{
  lib,
  config,
  ...
}:
{
  options = {
    hyprland.hyprpaper.enable = lib.mkEnableOption {
      default = true;
      description = "Enable hyprpaper";
    };
  };

  config = lib.mkIf config.hyprland.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        wallpaper = [
          {
            monitor = "eDP-1";
            path = "~/.local/share/wallpapers/current";
          }
          {
            monitor = "DP-1";
            path = "~/.local/share/wallpapers/current";
          }
        ];
      };
    };
  };
}
