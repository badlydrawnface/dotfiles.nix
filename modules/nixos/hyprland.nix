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
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
