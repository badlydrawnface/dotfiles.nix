{ pkgs, lib, config, ...}: {
  options = {
    ly.enable = lib.mkEnableOption {
      default = false;
      description = "Enable ly display manager";
    };
  };

  config = lib.mkIf config.ly.enable {
    services.displayManager.ly.enable = true;
  };
}