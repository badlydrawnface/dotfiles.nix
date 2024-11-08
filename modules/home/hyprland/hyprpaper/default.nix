{ pkgs, lib, config, ... }: {
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
          "~/Pictures/wallhaven-vq6kp8.jpg"
        ];

        wallpaper = [
          "DP-1,~/Pictures/wallhaven-vq6kp8.jpg"
        ];
      };
    };
  };
}