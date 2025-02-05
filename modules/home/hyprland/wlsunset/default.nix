{ pkgs, lib, config, ... }: {

  options = {
    hyprland.wlsunset.enable = lib.mkEnableOption "Enable wlsunset for night light gamma control";
  };

  # TODO try rebuilding hyprsunset
  config = lib.mkIf config.hyprland.wlsunset.enable {
    programs.wlsunset = {
      enable = true;
    };
  }
}