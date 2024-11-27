{ pkgs, lib, config, ...}: {
  options = {
    sddm.enable = lib.mkEnableOption {
      default = false;
      description = "Enable Simple Desktop Display Manager";
    };
  };

  config = lib.mkIf config.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}