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

  # all hypr
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig =
    ''
    monitor=DP-1,1920x1080@144,auto,1

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    exec-once = waybar & hyprpaper & wlsunset -l 40.3 -L -75.2 -t 3500

    # polkit
    exec-once=/usr/lib/polkit-kde-authentication-agent-1

    # get rid of the "empty app list" in dolphin
    env = XDG_MENU_PREFIX,arch-

    # cursor
    exec-once=hyprctl setcursor Bibata-Modern-Classic 24 

    # this is needed for now otherwise the cursor will not show
    cursor {
        no_hardware_cursors = true
    }

    # Set programs that you use
    $terminal = alacritty 
    $fileManager = dolphin 
    $menu = rofi 

    $browser = zen-browser 

    # Some default env vars.
    env = QT_QPA_PLATFORM,wayland
    env = QT_QPA_PLATFORMTHEME,qt6ct

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = us, ca
        kb_variant = , multix 
        kb_model =
        kb_options = grp:win_space_toggle
        kb_rules =

        follow_mouse = 1

        touchpad {
            natural_scroll = yes
      clickfinger_behavior = 1
        }

        # disable mouse acceleration
        accel_profile = flat
        sensitivity = -0.25 # -1.0 - 1.0, 0 means no modification.
    }

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 3
        gaps_out = 5    
        border_size = 3
        col.active_border = rgba(89b4f0ff) rgba(67b6f4dd) 45deg
        col.inactive_border = rgba(57586aaa)
        layout = dwindle

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10
        
        blur {
            enabled = true
            size = 10 
            passes = 1
        }

        blurls = waybar

        drop_shadow = yes
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(010219ff) 
    }

    animations {
        enabled = yes

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier=slide,0.05,0.9,0.1,1.1

        animation = windows, 1, 7, slide 
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_status = master
    }

    gestures {
        workspace_swipe = on 
    }

    misc {
        force_default_wallpaper = 0
        col.splash = rgba(cdd6f4ff)
    }

    # window rules
    # all firefox-based picture-in-picture 
    windowrulev2 = float, title:^(Picture-in-Picture)$
    windowrulev2 = size 800 450, title:(Picture-in-Picture)
    windowrulev2 = pin, title:^(Picture-in-Picture)$
    windowrulev2 = float, title:^(Firefox)$
    windowrulev2 = size 800 450, title:(Firefox)
    windowrulev2 = pin, title:^(Firefox)$

    windowrulev2 = fullscreen, initialclass:tf_linux64

    # cs2 tearing
    windowrulev2 = immediate, class:^(cs2)$

    # float the cs2 (steam) community server browser
    windowrulev2 = float,immediate,initialClass:steam,initialTitle:(Game Servers)

    $mainMod = SUPER

    bind = $mainMod, Q, exec, $terminal
    bind = $mainMod, C, killactive,
    bindl = $mainMod, A, exec, grim - | swappy -f -
    bindl = $mainMod SHIFT, A, exec, grim -g "$(slurp)" - | swappy -f -
    bind = $mainMod, M, exit,
    # uncomment if you are using a display manager, replacing the above bind
    # bind = $mainMod, M, exec, wlogout 
    bind = $mainMod, E, exec, $fileManager
    bind = $mainMod, F, fullscreen
    bind = $mainMode, W, exec, $browser
    bind = $mainMod, V, togglefloating, 
    bind = $mainMod, R, exec, $menu -show drun -show emoji 
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle
    bind = $mainMod, D, exec, hyprpicker -a

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Example special workspace (scratchpad)
    bind = $mainMod, S, togglespecialworkspace, magic
    bind = $mainMod SHIFT, S, movetoworkspace, special:magic

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    # keyboard window movement
    bind = $mainMod SHIFT,left ,movewindow, l
    bind = $mainMod SHIFT,right ,movewindow, r
    bind = $mainMod SHIFT,up ,movewindow, u
    bind = $mainMod SHIFT,down ,movewindow, d

    # Screen brightness
    bind = , XF86MonBrightnessUp, exec, brightnessctl s +5%
    bind = , XF86MonBrightnessDown, exec, brightnessctl s 5%-

    # Playback control (with playerctl)
    bind=, XF86AudioPlay,exec, playerctl play-pause
    bind=, XF86AudioNext,exec, playerctl next
    bind=, XF86AudioPrev,exec, playerctl previous

    # volume control
    binde =, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+

    binde =, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-

    bind =, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle 

    ''
  };

  # create user directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # mako, a notification daemon
  services.mako = {
    enable = true;
    font = "Iosevka 12";
    borderRadius = 20;
    defaultTimeout = 5;

    backgroundColor = "#1e1e2e";
    textColor = "cdd6f4";
    progressColor = "over #313244";
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka:size=11";
      };
    };
  };

  programs.kitty.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      name= "Papirus-dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    cursorTheme = {
      name = "Bibata-Cursor-Theme";
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
    config =
    ''
    {
      // Choose the order of the modulesaround
      "modules-left": ["custom/launcher", "hyprland/workspaces", "custom/media"],
      "modules-center": ["hyprland/window"],
      "modules-right": ["tray", "hyprland/language", "custom/pacman", "backlight", "network", "battery", "pulseaudio", "clock"],
       
      "custom/launcher": {
        "on-click": "rofi -show drun -show emoji",
        "format": " "
      },

      "hyprland/workspaces": {
        "disable-scroll": false,
        "all-outputs": true,
        "warp-on-scroll": false,
        "format": " {icon} ",
        "format-icons": {
          "1": "1",
          "2": "2",
          "3": "3",
          "4": "4",
          "5": "5",
          "6": "6",
          "7": "7",
          "8": "8",
          "9": "9"
        }
      },

      "hyprland/window": {
        "max-length": 40
      },
      "keyboard-state": {
        "numlock": true,
        "capslock": true,
        "format": "{name} {icon}",
        "format-icons": {
          "locked": "",
          "unlocked": ""
        }
      },

      "tray": {
        "spacing": 6 
      },
      
      "custom/pacman": {
        "format": "{icon} {}",
        "return-type": "json",
        "format-icons": {
          "pending-updates": " ",
          "updated": ""
        },
        "exec-if": "which waybar-updates",
        "exec": "waybar-updates"
      },

      "clock": {
        "timezone": "America/New_York",
        "tooltip-format": "<tt><small>{calendar}</small></tt>",
        "format-alt": "{:%m/%d/%Y}",
        "format": "{:%I:%M %p}"
      },
      "hyprland/language": {
        "format": "󰌌  {}",
        "format-en": "en",
        "format-fr": "fr",
        "format-it": "it"
      },

      "backlight": {
        // "device": "acpi_video1",
        "format": "{icon} {percent}%",
        "format-icons": ["", "", "", "", "", "", "", "", ""]
      },

      "network": {
        "interface": "enp34s0",
        "interval": 3,
        "format": " {bandwidthDownBytes}"
      },

      "battery": {
        "states": {
          "warning": 15
        },
        "format": "{icon} {capacity}%",
        "format-charging": "󰂄 {capacity}%",
        "format-warning": "󰂃 {capacity}%",
        "format-alt": "{icon} {time}",
        "format-icons": ["󰁺", "󰁻", "󰁽", "󰁽", "󰁿", "󰂁", "󰁹"]
      },

      "pulseaudio": {
        "on-click": "pavucontrol",
        "format": "{icon} {volume}%",
        "format-muted": " ",
        "format-icons": {
          "default": [" ", " ", " "]
        }
      },

      "custom/media": {
        "format": "{icon} {}",
        "return-type": "json",
        "max-length": 40,
        "format-icons": {
          "spotify": " ",
          "default": "🎜 "
        },
        "escape": true,
        "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null" // Script in resources folder
        // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
      }
    }
    '';
    style =
    ''
    @import "colors.css";

    * {
      font-family: Iosevka Nerd Font;
      font-weight: bold;
      font-size: 14px;
      min-height: 0;
      /** change padding to make the bar thinner or thicker **/
      padding: 0px;
      margin: 0;
      border-radius: 0;
    }

    window#waybar {
      background-color: @bg-transparent;
    }

    #custom-launcher {
      color: @color12;
      font-size: 20px;
      margin: 5;
      border-radius: 0.5rem;
    }

    #workspaces {
      border-radius: 0.5rem;
      margin: 5px;
      background-color: @color9;
    }  

    #workspaces button {
      min-width: 2rem;
      color: @color15;
      border-radius: 0.5rem;
    }

    #workspaces button.active {
      background-color: @color14;
      margin: 2px 2px;
      color: @color0;
    }

    #workspaces button.urgent {
      color: @color; 
    }

    #window,
    #tray,
    #language,
    #network,
    #custom-media,
    #backlight,
    #clock,
    #battery,
    #custom-pacman,
    #pulseaudio {
      background-color: @color9;
      color: @color15;
      margin: 5px 0;
      padding: 0rem 0.75rem 0rem;
    }

    #custom-media {
      border-radius: 1rem;
      background-color: @color9;
      margin-left: 4rem;
    }

    #window {
      border-radius: 0.5rem;
    }

    window#waybar.empty #window {
      background-color:transparent;
    }
      
    #language {
      border-radius: 0.5rem 0px 0px 0.5rem;
      margin-left: 1rem;
    }

    #battery.warning:not(.charging) {
      color: @color2;
    }

    #clock {
      border-radius: 0px 0.5rem 0.5rem 0px;
      margin-right: 1rem;
    }

    #tray {
      border-radius: 0.5rem;
    }
    ''
  }

  # Home Manager needs a bit of information about you and the paths it should
  # manage
  home.username = "bdface";
  home.homeDirectory = "/home/bdface";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
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
    vscode
    zed-editor
    librewolf
    obsidian
    gradience
    iosevka-bin
    fastfetch
    wl-clipboard
    wormhole-rs
    steam
    spotify
    discord
    discover-overlay
    lutris
    prismlauncher
    dolphin-emu
    ryujinx
    cemu
    pywal16
    pywalfox-native

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
