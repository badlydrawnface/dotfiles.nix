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
          font-family: "FantasqueSansM Nerd Font";
          font-weight: bold;
          font-size: 16px;
        }

        window#waybar {
          background-color: alpha(@base, 0.65);
        }

        #custom-launcher {
          color: @${accent};
          font-size: 22px;
          margin-left: 0.5rem;
        }

        #workspaces {
          border-radius: 5px;
          background-color: @surface0;
          margin: 2px;
          margin-left: 1rem;
        }

        #workspaces button {
          color: @text;
          border-radius: 5px;
          padding: 0px 2px;
          margin: 3px;
          transition: all 0.3s ease-in-out;
        }

        #workspaces button.active {
          background-color: @${accent};
          color: @crust;
          min-width: 35px;
        }

        #workspaces button.urgent {
          color: @red;
        }

        #window,
        #tray,
        #language,
        #network,
        #backlight,
        #clock,
        #battery,
        #power-profiles-daemon,
        #wireplumber {
          background-color: @surface0;
          color: @${accent};
          margin: 3px 0;
          padding: 0rem 0.5rem 0rem;
        }

        #custom-media {
          background-color: @green;
          color: @base;
          border-radius: 1rem;
          margin-left: 4rem;
        }

        #window {
          border-radius: 5px;
        }

        window#waybar.empty #window {
          background-color:transparent;
        }

        #language {
          border-radius: 5px 0px 0px 5px;
          margin-left: 1rem;
        }

        #battery.warning:not(.charging) {
          color: @red;
        }

        #clock {
          border-radius: 0px 5px 5px 0px;
          margin-right: 0.5rem;
        }
      '';
    };
  };
}
