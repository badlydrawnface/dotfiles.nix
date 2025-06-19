{ config, lib, pkgs, ... }: {

  options = {
    sway.enable = lib.mkEnableOption {
      default = false;
      description = "Enable sway";
    };
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      playerctl
      swaybg

      wayland.windowManager.sway = {
        enable = true;
        config = rec {
          modifier = "Mod4";
          # Use kitty as default terminal
          terminal = "kitty"; 
          startup = [
            {command = "waybar";}
            {command = "wlsunset";}
            {command = "steam -silent";}
            {command = "swaybg -i ~/.local/share/wallpapers/wallhaven-5g22q5.png";}
           ];
        };
      };
    ];
  };
}
