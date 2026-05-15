{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options = {
    desktops.hyprland.enable = lib.mkEnableOption "Enable Hyprland (system module)";
  };

  config = lib.mkIf config.desktops.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      portalPackage =
        pkgs.xdg-desktop-portal-hyprland;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
