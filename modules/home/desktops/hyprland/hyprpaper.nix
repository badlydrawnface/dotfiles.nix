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
        preload = [
          "~/.local/share/wallpapers/current"
        ];

        wallpaper = [
          "eDP-1,~/.local/share/wallpapers/current"
          "DP-1,~/.local/share/wallpapers/current"
        ];
      };
    };
  };
}
