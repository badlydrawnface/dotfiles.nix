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
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
      size = 24;
    };

    gtk = {
      enable = true;
      #theme = {
      #name = "adw-gtk3-dark";
      #package = pkgs.adw-gtk3;
      #};
      cursorTheme = {
        name = "catppuccin-mocha-dark-cursors";
        size = 24;
        package = pkgs.catppuccin-cursors.mochaDark;
      };
      # gtk.catppuccin.enable sets this
      # iconTheme = {
      #   name = "Papirus";
      #   package = pkgs.catppuccin-papirus-folders;
      # };
      font = {
        name = "Fira Sans";
        size = 11;
      };
    };
  };
}
