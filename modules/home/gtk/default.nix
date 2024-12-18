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
        name = "Breeze_Hacked";
        size = 24;
        package = pkgs.breeze-hacked-cursor-theme;
      };
      font = {
        name = "Inter";
        size = 11;
        package = pkgs.inter-nerdfont;
      };
    };
  };
}