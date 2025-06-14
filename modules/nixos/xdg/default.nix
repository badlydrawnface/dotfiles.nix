{ config, lib, pkgs, ... }: {
  options = {
    xdgPortals.enable = lib.mkEnableOption "Enable XDG portals";
  };

  config = lib.mkIf config.xdgPortals.enable {
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
}
