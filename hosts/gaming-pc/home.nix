{ config, pkgs, inputs, outputs, ... }:

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

  home.file.".config/alacritty/catppuccin-mocha.toml" = {
    source = ../../config/alacritty/catppuccin-mocha.toml;
  };

  programs.alacritty = {
    enable = true;
    # TODO get theme coloring
    settings = {
      import = ["~/.config/alacritty/catppuccin-mocha.toml"];
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
    extensions = with pkgs.vscode-extensions; [
        github.copilot
        github.copilot-chat
    ];
    userSettings = {
        "[nix]"."editor.tabSize" = 2;
        "editor.fontFamily" = "Iosevka NF, monospace";
        "editor.fontSize" = 16;
        "catppuccin.accentColor" = "lavender";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "terminal.integrated.fontSize" = "16";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      # enable right format
      "[format]" = {
        "format" = "[$all]($right_format)";
        "right_format" = "$time";
        "palette" = "catppuccin_mocha";
      };

    
      "[os]" = {
        "format" = "[$symbol]($style)";
        "style" = "red";
        "symbols.NixOS" = " ";
        "symbols.Macos" = " ";
        "symbols.Arch" = " ";
      };


      "[character]" = {
        "format" = "[$symbol]($style) ";
        "success_symbol" = "[[󰄛](green) ❯](peach)";
        "error_symbol" = "[[󰄛](red) ❯](peach)";
      };


      "[directory]" = {
        "truncation_length" = 4;
        "style" = "bold lavender";
      };


      "[username]" = {
        "style" = "bold green";
      };

      "[time]" = {
        "format" = "[$time]($style)";
        "style" = "surface2";
      };

      # catppuccin <https://github.com/catppuccin/starship>
      "[palettes.catppuccin_mocha]" = {
        "rosewater" = "#f5e0dc";
        "flamingo" = "#f2cdcd";
        "pink" = "#f5c2e7";
        "mauve" = "#cba6f7";
        "red" = "#f38ba8";
        "maroon" = "#eba0ac";
        "peach" = "#fab387";
        "yellow" = "#f9e2af";
        "green" = "#a6e3a1";
        "teal" = "#94e2d5";
        "sky" = "#89dceb";
        "sapphire" = "#74c7ec";
        "blue" = "#89b4fa";
        "lavender" = "#b4befe";
        "text" = "#cdd6f4";
        "subtext1" = "#bac2de";
        "subtext0" = "#a6adc8";
        "overlay2" = "#9399b2";
        "overlay1" = "#7f849c";
        "overlay0" = "#6c7086";
        "surface2" = "#585b70";
        "surface1" = "#45475a";
        "surface0" = "#313244";
        "base" = "#1e1e2e";
        "mantle" = "#181825";
        "crust" = "#11111b";
      };
    };
  };

  xdg = {
    enable = true;
    # add user folders (Desktop, Documents, etc.)
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mimeApps = {
      #TODO
    };
  };

  # all hypr

  home.file."Pictures/wallhaven-83ox2k.jpg" = {
    source = ../../wallpapers/wallhaven-83ox2k.jpg;
  };

  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      preload = [
        "~/Pictures/wallhaven-83ox2k.jpg"
      ];

      wallpaper = [
        "DP-1,~/Pictures/wallhaven-83ox2k.jpg"
      ];
    };
  };

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
        "col.active_border" = "rgba(89b4faee) rgba(cba6f7ee) 45deg";
        "col.inactive_border" = "rgba(1e1e2eaa)";

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

      "$mainMod" = "SUPER";

      "bind" = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, W, exec, $browser"
        "$mainMod, R, exec, $menu -show drun -show emoji"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, fullscreen"
        "$mainMod, V, togglefloating"
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
        "$mainMod, A, exec, grimshot edit screen -"
        "$mainMod SHIFT, A, exec, grimshot edit area -"
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

  # TODO
  # home.file.".config/swayosd/style.css" = {
  #   source = ../../config/swayosd/style.css;
  # };

  services.swayosd = {
    enable = true;
    # TODO style the OSD
    # stylePath = "~/.config/swayosd/mocha.css";
  };

  services.playerctld = {
    enable = true;
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

  # declare rasi file from config to ~/.local/share/rofi/catppuccin-mocha.rasi
  home.file.".local/share/rofi/catppuccin-mocha.rasi" = {
    source = ../../config/rofi/themes/catppuccin-mocha.rasi;
  };

  # browser
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-wayland;
    settings = {
      "identity.fxaccounts.enabled" = true;
    };
  };

  # as a fallback in
  programs.kitty.enable = true;

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
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
	      accent = "lavender";
      };
    };
    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        size = "standard";
        tweaks = [];
        accents = ["lavender"];
        variant = "mocha";
      };
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

  # get the css colors for waybar
  home.file.".config/waybar/mocha.css" = {
    source = ../../config/waybar/mocha.css;
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

      # TODO use home.file to add auxiliary files (i.e define-color css files and scripts)
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
    brave
    hyprpaper
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
    qt5ct
    qt6ct
    wlsunset
    pavucontrol
    grimblast
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
    QT_QPA_PLATFORMTHEME = "qt6ct";
    GRIMBLAST_EDITOR = "pix";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
