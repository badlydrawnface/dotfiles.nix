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
          "~/.local/share/wallpapers/G2l_3J6WsAA06aR.jpeg"
        ];

        # TODO modularize the display type
        wallpaper = [
          "eDP-1,~/.local/share/wallpapers/G2l_3J6WsAA06aR.jpeg"
          "DP-1,~/.local/share/wallpapers/G2l_3J6WsAA06aR.jpeg"
        ];
      };
    };
  };
}
