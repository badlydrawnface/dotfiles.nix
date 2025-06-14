{ pkgs, lib, config, ...}: {
  options = {
    sddm.enable = lib.mkEnableOption {
      default = false;
      description = "Enable SDDM";
    };
  };

  config = lib.mkIf config.sddm.enable {
    # enable catppuccin sddm theme
    catppuccin.sddm.enable = true;
    services.displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      wayland.enable = true;
      # this is going to give me kwallet...
      package = pkgs.kdePackages.sddm;
    };
  };
}
