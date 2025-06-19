{ config, lib, pkgs, ... }: {
  options = {
    desktops.sway.enable = lib.mkEnableOption {
      default = false;
      description = "Enable sway";
    };
  };

  config = lib.mkIf config.desktops.sway.enable {
    programs.sway = {
      enable = true;
      package = pkgs.sway;
      portalPackage = pkgs.xdg-desktop-portal-sway;
      wrapperFeatures.gtk = true;
    };
  };
}
