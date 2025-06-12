{ pkgs, lib, config, ... }: {

  options = {
    wmCommon.wlsunset.enable = lib.mkEnableOption "Enable wlsunset for night light gamma control";
  };

  config = lib.mkIf config.wmCommon.wlsunset.enable {
    services.wlsunset = {
      enable = true;
      package = pkgs.wlsunset;
      # Allentown, PA
      latitude = 40.6;
      longitude = -75.4;
      temperature.night = 3000;
    };
  };
}
