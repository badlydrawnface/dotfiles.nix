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
          "~/.local/share/wallpapers/wallhaven-yxdrex.png"
        ];

        # TODO modularize the display type
        wallpaper = [
          "eDP-1,~/.local/share/wallpapers/wallhaven-yxdrex.png"
          "DP-1,~/.local/share/wallpapers/wallhaven-yxdrex.png"
        ];
      };
    };
  };
}
