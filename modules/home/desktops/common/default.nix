{ config, lib, pkgs, ... } : {
  
  imports = [
    ./dunst
    ./rofi
    ./waybar
    ./wlsunset
  ];

  options = {
    wmCommon.enable = lib.mkEnableOption {
      default = false;
      description = "enable common WM configs (dunst, rofi, waybar etc.)";
    };
  };

  config = lib.mkIf config.wmCommon.enable {
    services.swayosd.enable = true;
    services.playerctld.enable = true;
  };
}
