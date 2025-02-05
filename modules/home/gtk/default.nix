{ pkgs, lib, config, ... }: {

  # TODO major refactor needed
  options = {
    myGtk.enable = lib.mkEnableOption "Enable cursor theme and fonts";
  };

  config = lib.mkIf config.myGtk.enable {
    gtk = {
      enable = true;
      cursorTheme = {
        name = "catppuccin-mocha-dark-cursors";
        size = 24;
        package = pkgs.catppuccin-cursors.mochaDark;
      };
      font = {
        name = "Fira Sans";
        size = 11;
      };
    };
  };
}
