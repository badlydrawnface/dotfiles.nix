{
  pkgs,
  lib,
  config,
  ...
}:
{

  # TODO major refactor needed
  options = {
    myGtk.enable = lib.mkEnableOption "Enable cursor theme and fonts";
  };

  config = lib.mkIf config.myGtk.enable {
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.catppuccin-cursors.macchiatoDark;
      name = "catppuccin-${config.catppuccin.accent}-dark-cursors";
      size = 24;
    };

    gtk = {
      enable = true;
      cursorTheme = {
        name = "catppuccin-${config.catppuccin.accent}-dark-cursors";
        size = 24;
        package = pkgs.catppuccin-cursors.macchiatoDark;
      };
      font = {
        name = "Adwaita Sans";
        size = 11;
      };
    };
  };
}
