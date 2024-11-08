{ pkgs, lib, config, ... }: {
  options = {
    dunst.enable = lib.mkEnableOption {
      default = true;
      description = "Enable dunst";
    };
  };
  
  config = lib.mkIf config.dunst.enable {
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
          font = "Inter Display 11";
        };
      };
    };
  };
}