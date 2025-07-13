{
  pkgs,
  lib,
  config,
  ...
}:
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
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "tray"
            "hyprland/language"
            "backlight"
            "network"
            "power-profiles-daemon"
            "battery"
            "wireplumber"
            "clock"
          ];

          "custom/launcher" = {
            on-click = "rofi -show drun -show emoji";
            format = " ";
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
            format = "󰌌   {}";
            format-en = "en";
            format-fr = "fr";
            format-it = "it";
          };

          "backlight" = {
            # device = "acpi_video1"
            format = "{icon}  {percent}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
          };

          "network" = {
            interval = 3;
            format = "  {bandwidthDownBytes}";
            on-click = "kitty nmtui";
          };

          "battery" = {
            states = {
              warning = 15;
            };
            format = "{icon}  {capacity}%";
            format-charging = "󰂄  {capacity}%";
            format-warning = "󰂃  {capacity}%";
            format-alt = "{icon}  {time}";
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
            tooltip-format = "Power profile: {profile}\nDriver: {driver}";
            tooltip = true;
            format-icons = {
              performance = "";
              balanced = "";
              power-saver = "";
            };
          };

          "wireplumber" = {
            on-click = "pavucontrol";
            format = "{icon}   {volume}%";
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
          font-family: "Fira Sans", "Iosevka Nerd Font";
          font-weight: bold;
          font-size: 14px;
        }

        window#waybar {
          background-color: @base;
        }

        #custom-launcher {
          color: @green;
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
          background-color: @green;
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
          color: @green;
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

        #tray {
          border-radius: 5px;
        }
      '';
    };
  };
}
