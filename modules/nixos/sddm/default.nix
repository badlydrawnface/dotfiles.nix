{ pkgs, lib, config, ...}: {
  options = {
    sddm.enable = lib.mkEnableOption {
      default = false;
      description = "Enable Simple Desktop Display Manager";
    };
  };

  config = lib.mkIf config.sddm.enable {
    # enable catppuccin sddm theme
    catppuccin.sddm.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };
  };
}
