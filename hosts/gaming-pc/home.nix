{ config, pkgs, inputs, outputs, ... }:

# define hyprland flake packages
let
  hyprlandPkgs = inputs.hyprland.packages.${pkgs.system};
  hyprsunsetPkgs = inputs.hyprsunset.packages.${pkgs.system};
in
{
  # # TODO finish modularizing the flake
  # imports = [
  #   ../../myModules/homeModules/features/vscode.nix
  # ];

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.git = {
    enable = true;
    userEmail = "bdface@proton.me";
    userName = "badlydrawnface";
    aliases = {
      hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  programs.alacritty = {
    enable = true;
    # TODO get theme coloring
    settings = {
      font = {
        size = 12;
        normal = {
          family = "IosevkaNF";
          style = "Regular";
        };
        bold = {
          family = "IosevkaNF";
          style = "Bold";
        };
        italic = {
          family = "IosevkaNF";
          style = "Italic";
        };
        bold_italic = {
          family = "IosevkaNF";
          style = "Bold Italic";
        };
      };
      window = {
        dynamic_padding = true;
        decorations = "full";
        title = "Alacritty";
        opacity = 0.8;
      };

      colors = {
        draw_bold_text_with_bright_colors = true;
      };
      selection = {
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
        save_to_clipboard = true;
      };
      cursor = {
        style = "Underline";
        vi_mode_style = "None";
        unfocused_hollow = true;
        thickness = 0.15;
      };
      mouse = {
        hide_when_typing = true;
        bindings = [
          {
            mouse = "Middle";
            action = "PasteSelection";
          }
        ];
      };
      keyboard = {
        bindings = [
          {
            key = "Paste";
            action = "Paste";
          }
          {
            key = "Copy";
            action = "Copy";
          }
          {
            key = "L";
            mods = "Control";
            action = "ClearLogNotice";
          }
          {
            key = "L";
            mods = "Control";
            mode = "~Vi";
            chars = "\f";
          }
        ];
      };
    };
  };

  # fallback in case alacritty doesn't work
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka:size=11";
      };
    };
  };

  programs.vscode = {
    enable = true;   
    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "editor.fontFamily" = "Iosevka NF";
      "editor.fontSize" = 16;
      "terminal.integrated.fontSize" = 16;
      "catppuccin.accentColor" = "mauve";
      "workbench.iconTheme" = "catppuccin-mocha";
      "workbench.colorTheme" = "Catppuccin Mocha";
    };

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        github.copilot
        github.copilot-chat
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        gruntfuggly.todo-tree
        rust-lang.rust-analyzer
        ms-vsliveshare.vsliveshare
        ms-python.python
        dart-code.flutter
      ];
    };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
    '';
  };

  programs.starship = {
    enable = true;
  };

  xdg = {
    enable = true;
    # add user folders (Desktop, Documents, etc.)
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        # file manager
        "inode/directory" = "nemo.desktop";
        "video/*" = "mpv.desktop";
        "audio/*" = "mpv.desktop";
        "image/*" = "xviewer.desktop";
        "text/*" = "nvim.desktop";
        "application/pdf" = [ "xreader.desktop"  "brave.desktop" ];

        # browser
        "x-scheme-handler/http" = "brave.desktop";
        "x-scheme-handler/https" = "brave.desktop";
        "text/html" = "brave.desktop";
      };
    };
  };

  # all hypr

  home.file."Pictures/wallhaven-vq6kp8.jpg" = {
    source = ../../wallpapers/wallhaven-vq6kp8.jpg;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/wallhaven-vq6kp8.jpg"
      ];

      wallpaper = [
        "DP-1,~/Pictures/wallhaven-vq6kp8.jpg"
      ];
    };
  };

  wayland.windowManager.hyprland = {
    #TODO
    enable = true;
    package = hyprlandPkgs.hyprland;
    settings = {
      "monitor" = "DP-1,1920x1080@144,auto,1";

      # autostart programs
      "exec-once" = [
         "/usr/lib/polkit-kde-authentication-agent-1"
         "waybar & hyprpaper"
         "hyprctl setcursor Bibata-Modern-Classic 24"
      ];

      "$terminal" = "alacritty";
      "$fileManager" = "nemo";
      "$menu" = "rofi";
      "$browser" = "librewolf";

      "input" = {
        "kb_layout" = "us, ca";
        "kb_variant" = ", multix";
        "kb_options" = "grp:win_space_toggle";

        "touchpad" = {
          "natural_scroll" = true;
          "clickfinger_behavior" = 1;
        };

        # disable mouse acceleration
        "accel_profile"  = "flat";
        "sensitivity" = -0.25;
      };

      "general" = {
        "gaps_in" = 3;
        "gaps_out" = 5;
        "border_size" = 3;
        #TODO abstract this from the config into a seperate color config
        "col.active_border" = "rgba($mauveAlphaee) rgba($rosewaterAlphaee) 65deg";
        "col.inactive_border" = "rgba($surface0Alphacc)";

        "layout" = "dwindle";
      };

      "decoration" = {
        "rounding" = 10;

        "blur" = {
          "enabled" = true;
          "size" = 10;
          "passes" = 1;
        };

        "blurls" = [
          "waybar"
          "rofi"
        ];

        "drop_shadow" = true;
        "shadow_range" = 4;
        "shadow_render_power" = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      "animations" = {
        "enabled" = true;

        "bezier" = "slide,0.05,0.9,0.1,1.1";

        "animation" = [
          "windows,1,7,slide"
          "windowsOut,1,7,default,popin 80%"
          "border,1,10,default"
          "borderangle,1,8,default"
          "fade,1,7,default"
          "workspaces,1,6,default"
        ];
      };

      "dwindle" = {
        "pseudotile" = true;
        "preserve_split" = true;
      };

      "gestures" = {
        "workspace_swipe" = "on";
      };

      "misc" = {
        "col.splash" = "rgba(cdd6f4ff)";
      };

      # TODO windowrules
      "windowrulev2" = [
        "float, title:^(Picture-in-Picture)$"
        "size 800 450, title:(Picture-in-Picture)"
        "pin, title:^(Picture-in-Picture)"
        "float, title:^(Firefox)$"
        "size 800 450, title:(Firefox)"
        "pin, title:^(Firefox)$"

        # chromium pip
        "float, title:^(Picture in picture)$"
        "pin, title:^(Picture in picture)$"
        "size 800 450, title:(Picture in picture)"

      ];

      "$mainMod" = "SUPER";

      "bind" = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, W, exec, $browser"
        "$mainMod, R, exec, $menu -show drun -show emoji"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, fullscreen"
        "$mainMod, V, togglefloating"
        "$mainMod, M, exit"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"

        # focus movement with arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

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

        # scratchpad workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # scroll through workspaces
        "$mainMod, mouse_up, workspace, e+1"
        "$mainMod, mouse_down, workspace, e-1"

        # keyboard window movement
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # screen brightness
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"

        # playback
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # mute with swayosd
        ", XF86AudioMute, exec, swayosd-client --max-volume 100 --output-volume mute-toggle"
      ];

      "binde" = [
        # volume control with swayosd
        ", XF86AudioRaiseVolume, exec, swayosd-client --max-volume 100 --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --max-volume 100 --output-volume lower"
      ];

      "bindl" = [
        # copy and pastes to the clipboard
        "$mainMod, A, exec, grimblast copy screen"
        "$mainMod SHIFT, A, exec, grimblast copy area -"
      ];

      "bindm" = [
        # drag to resize with mouse
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resize_window"
      ];
    };
  };

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

  services.swayosd = {
    enable = true;
  };

  services.playerctld = {
    enable = true;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # wayland fork of rofi, probably will replace with wofi, but will take time
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
      "identity.fxaccounts.enabled" = true;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };

  # wlsunset, a night light service for wayland compositors
  services.wlsunset = {
    #FIXME the timing isnt working correctly
    enable = false;
    gamma = 3500;
    latitude = 40.3;
    longitude = -75.2;
  };

  # home.file.".config/gtk-4.0/mocha.css" = ../../config/gtk/mocha.css;

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      icon.enable = true;
      accent = "mauve";
      flavor = "mocha";
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      size = 24;
      package = pkgs.bibata-cursors;
    };
    font = {
      name = "Inter";
      size = 11;
      package = pkgs.inter-nerdfont;
    };
  };

  # set prefer-dark for gtk4 and others
  dconf.settings = {
    "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
    };
  };

  # get the python script for the media player
  home.file.".config/waybar/mediaplayer.py" = {
    source = ../../config/waybar/mediaplayer.py;
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
        font-family: "Inter Display" ,"Iosevka Nerd Font";
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
        color: @mauve;
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
        background-color: @mauve;
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
        color: @mauve;
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
    libreoffice-fresh
    litemdview
    brave
    hyprpaper
    hyprsunsetPkgs.hyprsunset
    playerctl
    discord
    zed-editor
    gradience
    fastfetch
    wl-clipboard
    wormhole-rs
    steam
    mpv
    discord
    discover-overlay
    lutris
    prismlauncher
    dolphin-emu
    ryujinx
    cemu
    spotify
    heroic
    gimp
    inkscape
    kdenlive
    catppuccin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    wlsunset
    pavucontrol
    grimblast
    android-studio
  ];

  home.sessionVariables = {
    GRIMBLAST_EDITOR = "xviewer";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
