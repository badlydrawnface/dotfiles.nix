{ config, pkgs, ... }:

{
  
  # github-cli and credential helper
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  # gitconfig
  programs.git = {
    enable = true;
    userEmail = "bdface@proton.me";
    userName = "badlydrawnface";
  };

  programs.alacritty = {
    enable = true;
    # TODO config
  };

  # all hypr
  wayland.windowManager.hyprland = {
    #TODO
    enable = true;
    settings = {
      "monitor" = "DP-1,1920x1080@144,auto,1";

      # autostart programs
      "exec-once" = [
         "/usr/lib/polkit-kde-authentication-agent-1"
         "waybar & hyprpaper & wlsunset"
         "hyprctl setcursor Bibata-Modern-Classic 24"
      ];

      "$terminal" = "alacritty";
      "$fileManager" = "nemo";
      "$menu" = "rofi";
      "$browser" = "librewolf";

      "$mainMod" = "SUPER";

      "bind" = [
        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, Q, exec, $terminal"
        "$mainMod, W, exec, $browser"
        "$mainMod, C, killactive"
        "$mainMod, R, exec, $menu -show drun -show emoji"
	"$mainMod, E, exec, $fileManager"
      ];

      blurls = [
        "waybar"
      ];
    };
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka:size=11";
      };
    };
  };

  # notifications
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#89b4fa";
        separator_color = "frame";
        background = "#1e1e2e";
        foreground = "cdd6f4";
      };

      urgency_critical = {
        frame_color = "#fab387";
      };
    };
  };

  # wayland fork of rofi, probably will replace with wofi, but will take time
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [ pkgs.rofi-emoji-wayland ];
    theme = "~/.local/share/rofi/catppuccin-mocha.rasi";
    extraConfig = {
      modi = "run,drun,window,emoji";
      icon-theme = "Papirus-dark";
      show-icons = true;
      terminal = "alacritty";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 󰕰  Window";
      display-Network = " 󰤨  Network";
      display-emoji = " 󰞅  Emoji";
      sidebar-mode = true;
    };
  };

  # browser
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-wayland;
    settings = {
      "identitiy.fxaccounts.enabled" = true;
    };
  };

  programs.kitty.enable = true;

  # wlsunset, a night light service for wayland compositors
  services.wlsunset = {
    enable = true;
    gamma = 3500;
    latitude = 40.3;
    longitude = -75.2;
  };

  gtk = {
    enable = true;
    gtk4.extraCss = ''@import url("./mocha.css");'';
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
	      accent = "lavender";
      };
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      size = 24;
      package = pkgs.bibata-cursors;
    };
    font = {
      name = "Fira Sans";
      size = 12;
      package = pkgs.fira-sans;
    };
  };

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

        "keyboard-state" = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        "tray" = {
          spacing = 6; 
        };
        
        "clock" = {
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          format-alt = "{:%m/%d/%Y}";
          format = "{:%I:%M %p}";
        };

        "hyprland/language" = {
          format = "󰌌  {}";
          format-en = "en";
          format-fr = "fr";
          format-it = "it";
        };

        "backlight" = {
          # device = "acpi_video1"
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };

        "network" = {
          interface = "enp34s0";
          interval = 3;
          format = " {bandwidthDownBytes}";
        };

        "battery" = {
          states = {
            warning = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-warning = "󰂃 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = ["󰁺" "󰁻" "󰁽" "󰁽" "󰁿" "󰂁" "󰁹"];
        };

        "wireplumber" = {
          on-click = "pavucontrol";
          format = "{icon} {volume}%";
          format-muted = " ";
          format-icons = {
            default = [" " " " " "];
          };
        };

      # TODO use home.files to add auxiliary files (i.e define-color css files and scripts)
      #   custom/media = {
      #     format = "{icon} {}";
      #     return-type = "json";
      #     max-length = 40;
      #     format-icons = {
      #       spotify = " ";
      #       default = "🎜 ";
      #     },
      #     escape = true;
      #     exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null" # Script in resources folder
      #     // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
      #   }
      # };
      };
    };
    style = ''
      /** https://github.com/catppuccin/waybar **/
      @import "mocha.css";

      * {
        font-family: Iosevka Nerd Font;
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
        color: @lavender;
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
        background-color: @lavender;
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
        color: @mauve;
        border-radius: 1rem;
      }

      window#waybar.empty #window {
        background-color:transparent;
      }
        
      #language {
        color: @peach;
        border-radius: 1rem 0px 0px 1rem;
        margin-left: 1rem;
      }

      #network {
        color: @teal;
      }

      #battery {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }

      #wireplumber {
        color: @yellow;
      }

      #clock {
        color: @blue;
        border-radius: 0px 1rem 1rem 0px;
        margin-right: 1rem;
      }

      #tray {
        border-radius: 1rem;
      }

    '';  
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage
  home.username = "bdface";
  home.homeDirectory = "/home/bdface";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # hello
    vesktop
    discord
    vscode
    zed-editor
    obsidian
    gradience
    iosevka-bin
    fastfetch
    wl-clipboard
    wormhole-rs
    steam
    discord
    discover-overlay
    lutris
    prismlauncher
    dolphin-emu
    ryujinx
    cemu
    pywal16
    pywalfox-native
    spotify
    heroic
    gimp
    inkscape
    kdenlive
    catppuccin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    qt5ct
    qt6ct
    wlsunset
    pavucontrol


    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # rofi theme #TODO they might need to be nix files instead
    # ".local/share/rofi/catppuccin-mocha.rasi" = ../../config/rofi/themes/catppuccin-mocha.rasi;

    # # hyprland color configs
    # ".config/hypr/themes/latte.conf" = ../../config/hypr/latte.conf;
    # ".config/hypr/themes/frappe.conf" = ../../config/hypr/frappe.conf;
    # ".config/hypr/themes/macchiato.conf" = ../../config/hypr/macchiato.conf;
    # ".config/hypr/themes/mocha.conf" = ../../config/hypr/mocha.conf;

    # waybar colors #TODO need to figure out how to fix syntax issues when building with css files
    # ".config/waybar/latte.css" = ../../config/waybar/latte.css;
    # ".config/waybar/frappe.css" = ../../config/waybar/frappe.css;
    # ".config/waybar/macchiato.css" = ../../config/waybar/macchiato.css;
    # ".confrig/waybar/mocha.css" = ../../config/waybar/mocha.css;

    # ".config/gtk-4.0/mocha.css" = ../../config/gtk/mocha.css;
    
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bdface/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
