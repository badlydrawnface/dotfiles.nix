{ pkgs, lib, config, ... }: {
  options = {
    sysQt.enable = lib.mkEnableOption "Enable kvantum and other Qt configs";
  };

  config = lib.mkIf config.sysQt.enable { 
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "breeze";
    };
    
    environment.systemPackages = with pkgs; [
      qt6ct
      libsForQt5.qtstyleplugin-kvantum
      catppuccin-kvantum
      libsForQt5.qt5ct
      catppuccin-qt5ct
    ];
  };
}
