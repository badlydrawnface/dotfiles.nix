{ pkgs, lib, config, ... }: {

  options = {
    hyprland.wlsunset.enable = lib.mkEnableOption "Enable wlsunset for night light gamma control";
  };

  config = lib.mkIf config.hyprland.wlsunset.enable {
    services.wlsunset = {
      enable = true;
      # Allentown, PA
      latitude = 40.6;
      longitude = -75.4;
    };
  };
}