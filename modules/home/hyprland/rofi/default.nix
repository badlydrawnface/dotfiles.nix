{ pkgs, lib, config, ... }: {
  options = {
    hyprland.rofi.enable = lib.mkEnableOption {
      default = true;
      description = "Enable wayland fork of Rofi";
    };
  };

  config = lib.mkIf config.hyprland.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = [ pkgs.rofi-emoji-wayland ];
      font = "Inter Display 11, Iosevka Nerd Font 11";
      extraConfig = {
        modi = "run,drun,window,emoji";
        icon-theme = "Papirus-dark";
        show-icons = true;
        terminal = "alacritty";
        drun-display-format = "{icon} {name}";
        location = 8;
        height = "100%";
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "   Apps";
        display-run = "   Run";
        display-window = " 󰕰  Window";
        display-Network = " 󰤨  Network";
        display-emoji = " 󰞅  Emoji";
        sidebar-mode = true;
      };
    };
  };
}