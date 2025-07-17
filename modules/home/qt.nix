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
  };
}
