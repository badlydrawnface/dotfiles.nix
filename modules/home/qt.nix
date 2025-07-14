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
    qt = {
      enable = true;
      style = {
        package = pkgs.adwaita-qt;
        name = "adwaita-dark";
      };
    };
    # necessary to use qtct
    catppuccin.kvantum.enable = false;

    home.packages = with pkgs; [
      libsForQt5.qt5ct
      qt6ct
      qt6Packages.qtstyleplugin-kvantum
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
