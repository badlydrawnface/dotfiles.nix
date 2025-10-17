{
  config,
  lib,
  pkgs,
  ...
}:
{

  imports = [
    ./dunst.nix
    ./rofi.nix
    ./waybar.nix
    ./wlsunset.nix
  ];

  options = {
    wmCommon.enable = lib.mkEnableOption {
      default = false;
      description = "enable common WM configs (dunst, rofi, waybar etc.)";
    };
  };

  config = lib.mkIf config.wmCommon.enable {
    wmCommon.dunst.enable = true;
    wmCommon.rofi.enable = true;
    wmCommon.waybar.enable = true;
    wmCommon.wlsunset.enable = true;

    services.swayosd.enable = true;
    services.playerctld.enable = true;

    home.packages = with pkgs; [
      slurp
      grim
      swappy
      wf-recorder
      overskride
      syshud
    ];

    # swappy config
    xdg.configFile."swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures/swappy
    '';
  };
}
