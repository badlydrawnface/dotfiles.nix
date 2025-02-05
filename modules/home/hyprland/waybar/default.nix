{ pkgs, lib, config, ... }: {
  options = {
    hyprland.waybar.enable = lib.mkEnableOption "Enable waybar configurations and style";
  };

  config = lib.mkIf config.hyprland.waybar.enable {
    programs.waybar = {
      enable = true;
      settings =
      {
        mainBar = {
          modules-left =  [ "custom/launcher" "hyprland/workspaces" "custom/media" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [ "tray" "hyprland/language" "backlight" "network" "battery" "wireplumber" "clock" ];

          "custom/launcher" = {
            on-click = "rofi -show drun -show emoji";
            format = " ";
          };

          "hyprland/workspaces" = {
            disable-scroll = false;
            all-outputs = true;
            warp-on-scroll = false;
            format = " {icon} ";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
            };
          };

          "hyprland/window" = {
            max-length = 40;
          };

          "clock" = {
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            format-alt = "{:%m/%d/%Y}";
            format = "{:%I:%M %p}";
          };

          "hyprland/language" = {
            format = "󰌌   {}";
            format-en = "en";
            format-fr = "fr";
            format-it = "it";
          };

          "backlight" = {
            # device = "acpi_video1"
            format = "{icon}  {percent}%";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };

          "network" = {
            interface = "enp34s0";
            interval = 3;
            format = "  {bandwidthDownBytes}";
          };

          "battery" = {
            states = {
              warning = 15;
            };
            format = "{icon}  {capacity}%";
            format-charging = "󰂄  {capacity}%";
            format-warning = "󰂃  {capacity}%";
            format-alt = "{icon}  {time}";
            format-icons = ["󰁺" "󰁻" "󰁽" "󰁽" "󰁿" "󰂁" "󰁹"];
          };

          "wireplumber" = {
            on-click = "pavucontrol";
            format = "{icon}   {volume}%";
            format-muted = " ";
            format-icons = {
              default = [" " " " " "];
            };
          };

          "tray" = {
            # kdeconnect-indicator is passive so it won't show otherwise
            show-passive-items = true;
            spacing = 10;
          };

          # TODO use home.file to add auxiliary files (i.e define-color css files and scripts)
          "custom/media" = {
            format = "{icon} {}";
            return-type = "json";
            max-length = 40;
            format-icons = {
              spotify = " ";
              default = "🎜 ";
            };
            escape = true;
            exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
            # "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
          };
        };
      };
    
      style = ''  
        * {
          font-family: "Fira Sans", "Iosevka Nerd Font";
          font-weight: bold;
          font-size: 14px;
          min-height: 0;
          padding: 1px;
          margin: 0;
          border-radius: 0;
        }
    
        window#waybar {
          background-color: rgba(30, 30, 46, 0.5);
          transition-property: background-color;
          transition-duration: 0.5s;
        }
    
        #custom-launcher {
          color: @maroon;
          font-size: 22px;
          margin-left: 1rem;
        }
    
        #workspaces {
          border-radius: 0.75rem;
          margin: 5px;
          background-color: @surface0;
          margin-left: 1rem;
        }
    
        #workspaces button {
          min-width: 2em;
          color: @text;
          border-radius: 0.75rem;
        }
    
        #workspaces button.active {
          background-color: @maroon;
          margin: 2px 2px;
          color: @base;
        }
    
        #workspaces button.urgent {
          color: @red;
        }
    
        #window,
        #tray,
        #language,
        #network,
        #custom-media,
        #backlight,
        #clock,
        #battery,
        #wireplumber {
          background-color: @surface0;
          color: @sapphire;
          margin: 5px 0;
          padding: 0rem 0.75rem 0rem;
        }
    
        #custom-media {
          background-color: @green;
          color: @base;
          border-radius: 1rem;
          margin-left: 4rem;
        }
    
        #window {
          border-radius: 1rem;
        }
    
        window#waybar.empty #window {
          background-color:transparent;
        }
    
        #language {
          border-radius: 1rem 0px 0px 1rem;
          margin-left: 1rem;
        }

        #battery.warning:not(.charging) {
          color: @red;
        }
    
        #clock {
          border-radius: 0px 1rem 1rem 0px;
          margin-right: 1rem;
        }
    
        #tray {
          border-radius: 1rem;
        }
      '';
    };
  };
}
