{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption {
      default = false;
      description = "Enable hyprland";
    };
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      playerctl
    ];

    hyprland.hyprlock.enable = true;
    hyprland.hypridle.enable = true;
    hyprland.hyprpaper.enable = true;
    services.hyprpolkitagent.enable = true;

    catppuccin.hyprland.enable = false;

    xdg.configFile."hypr" = {
      source = ../../../../config/hypr;
      recursive = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
    };
  };
}
