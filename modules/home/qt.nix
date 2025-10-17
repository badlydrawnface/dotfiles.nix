{
  pkgs,
  lib,
  config,
  ...
}:
let
  # iterated from the catppuccin flake
  cfg = config.catppuccin.kvantum;

  themeName = "catppuccin-${cfg.flavor}-${cfg.accent}";
in
{
  options = {
    myQt.enable = lib.mkEnableOption "Enable kvantum and other Qt configs";
  };

  config = lib.mkIf config.myQt.enable {
    catppuccin.kvantum.enable = false;
    qt = {
      enable = true;
      platformTheme.name = "qtct";
    };
    home.packages = with pkgs; [
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      qt6ct
      qt6Packages.qtstyleplugin-kvantum
      catppuccin-kvantum
      kdePackages.breeze-icons
    ];
    xdg.configFile = {
      "Kvantum/${themeName}".source = "${config.catppuccin.sources.kvantum}/share/Kvantum/${themeName}";
      "Kvantum/kvantum.kvconfig" = lib.mkIf cfg.apply {
        text = ''
          [General]
          theme=${themeName}
        '';
      };
    };

    # add qtct configs from config folder (set kvantum as style, set font, icon theme et al.)
    home.file.".config/qt5ct/qt5ct.conf" = {
      source = ../../config/qt5ct.conf;
    };
    home.file.".config/qt6ct/qt6ct.conf" = {
      source = ../../config/qt6ct.conf;
    };
  };
}
