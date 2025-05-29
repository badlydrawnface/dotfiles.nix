{ pkgs, lib, config, ... }: {
  options = {
    hyprland.dunst.enable = lib.mkEnableOption {
      default = true;
      description = "Enable dunst";
    };
  };
  
  config = lib.mkIf config.hyprland.dunst.enable {
    # notifications
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "Papirus-dark";
        package = pkgs.catppuccin-papirus-folders;
        size = "32x32";
      };
      settings = {
        global = {
          font = "Fira Sans 11";
        };
      };
    };
  };
}