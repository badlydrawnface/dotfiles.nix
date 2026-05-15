{
  lib,
  config,
  ...
}:
let
  accent = config.catppuccin.accent;
in
{
  options = {
    wmCommon.waybar.enable = lib.mkEnableOption "Enable waybar configurations and style";
  };

  config = lib.mkIf config.wmCommon.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          modules-left = [
            "custom/launcher"
            "hyprland/workspaces"
          ];
          # modules-center = [ "hyprland/window" ];
          modules-right = [
            "hyprland/language"
            "tray"
            "network"
            "power-profiles-daemon"
            "battery"
            "wireplumber"
            "clock"
          ];

          "custom/launcher" = {
            on-click = "rofi -show drun -show emoji";
            format = " ";
            tooltip-format = "Open Menu";
          };

          "hyprland/workspaces" = {
            format = "{icon}";
            disable-scroll = false;
            all-outputs = true;
            warp-on-scroll = false;
          };

          "hyprland/window" = {
            max-length = 42;
          };

          "clock" = {
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            format-alt = "{:%m/%d/%Y}";
            format = "{:%I:%M %p}";
          };

          "hyprland/language" = {
            format = "󰌌 {}";
            format-en = "en";
            format-fr = "fr";
            format-it = "it";
          };

          "network" = {
            interval = 3;
            format = "{}";
            format-wifi = "󰖩 ";
            format-ethernet = "󰈀 ";
            format-disconnected = "󰌙";
            tooltip-format = " {bandwidthDownBytes}\n {bandwidthUpBytes}";
            tooltip-format-wifi = "{essid} ({signalStrength}%)\n {bandwidthDownBytes}\n {bandwidthUpBytes}";
            tooltip-format-ethernet = "{ifname} \n {bandwidthDownBytes}\n {bandwidthUpBytes}";
          };

          "battery" = {
            states = {
              warning = 15;
            };
            format = "{icon}";
            tooltip-format = "{capacity}%, {time}";
            format-charging = "󰂄";
            format-warning = "󰂃";
            format-icons = [
              "󰁺"
              "󰁻"
              "󰁽"
              "󰁽"
              "󰁿"
              "󰂁"
              "󰁹"
            ];
          };

          "power-profiles-daemon" = {
            format = "{icon}";
            tooltip-format = "Power profile: {profile}";
            tooltip = true;
            format-icons = {
              performance = " ";
              balanced = " ";
              power-saver = " ";
            };
          };

          "wireplumber" = {
            on-click = "pwvucontrol";
            format = "{icon}";
            format-muted = " ";
            format-icons = {
              default = [
                " "
                " "
                " "
              ];
            };
          };

          "tray" = {
            # kdeconnect-indicator is passive so it won't show otherwise
            show-passive-items = true;
            spacing = 10;
          };
        };
      };

      style = ''
        * {
          font-family: FantasqueSansMNerd Font;
          font-weight: bold;
          font-size: 16px;
          min-height: 0;
        }

        window#waybar {
          background-color: alpha(@base, 0.5);
          transition-property: background-color;
          transition-duration: 0.5s;
        }

        #custom-launcher {
          color: @${accent};
          font-size: 20px;
          background-color: @base;
          padding-left: 0.5rem;
          padding-right: 0.25rem;
        }

        #workspaces {
          border-radius: 0 0 0.85rem 0;
          padding: 2px;
          color: @text;
          background-color: @base;
        }

        #workspaces button {
          color: @overlay2;
          padding: 0 4px;
          border-radius: 1rem;
          min-width: 0px;
          transition: all 0.25s ease;
        }

        #workspaces button.active {
          min-width: 30px;
          padding: 0 10px;
          background-color: @${accent};
          margin: 2px;
          min-width: 2.3em;
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
        #power-profiles-daemon,
        #wireplumber {
          color: @text;
          background-color: @base;
          padding: 6px;
        }
        window#waybar.empty #window {
          background-color:transparent;
        }

        #battery.warning:not(.charging) {
          color: @red;
        }


        #language {
          border-radius: 0 0 0 0.85em;
        }
      '';
    };
  };
}
