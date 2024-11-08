{ pkgs, lib, config, ... }: {

  options = {
    myGtk.enable = lib.mkEnableOption "Enable gtk theme, cursor theme and fonts";
  };

  config = lib.mkIf config.myGtk.enable {
    gtk = {
      enable = true;
      catppuccin = {
        enable = true;
        icon.enable = true;
      };
      cursorTheme = {
        name = "Bibata-Modern-Classic";
        size = 24;
        package = pkgs.bibata-cursors;
      };
      font = {
        name = "Inter";
        size = 11;
        package = pkgs.inter-nerdfont;
      };
    };
  };
}