{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.catppuccin;
  cursorVariant = "${cfg.flavor}Dark";
in
{

  # TODO major refactor needed
  options = {
    myGtk.enable = lib.mkEnableOption "Enable cursor theme and fonts";
  };

  config = lib.mkIf config.myGtk.enable {
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.catppuccin-cursors.${cursorVariant};
      name = "catppuccin-${cfg.flavor}-dark-cursors";
      size = 24;
    };

    gtk = {
      enable = true;
      cursorTheme = {
        name = "catppuccin-${cfg.flavor}-dark-cursors";
        size = 24;
        package = pkgs.catppuccin-cursors.${cursorVariant};
      };
      font = {
        name = "Adwaita Sans";
        size = 11;
      };
    };
  };
}
