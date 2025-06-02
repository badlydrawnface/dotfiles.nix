{ pkgs, lib, config, ... }: {
  options = {
    myQt.enable = lib.mkEnableOption "Enable kvantum and other Qt configs";
  };

  config = lib.mkIf config.myQt.enable {
    # #TODO derive this into different flavors and accents
    # xdg.configFile = {
    #   "Kvantum/catppuccin".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/catppuccin-macchiato-sapphire";
    #   "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=Catppuccin";
    # };
  };
}