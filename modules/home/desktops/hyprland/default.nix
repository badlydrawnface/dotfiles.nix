{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption {
      default = false;
      description = "Enable hyprland";
    };
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      hyprpaper
      playerctl
      hyprsunset
      hyprdim
    ];

    hyprland.hyprlock.enable = true;
    hyprland.hypridle.enable = true;
    hyprland.hyprpaper.enable = true;
    services.hyprpolkitagent.enable = true;

    wayland.windowManager.hyprland = {
      #TODO
      enable = true;
      # needed for  to work
      systemd.enable = false;
      settings = {
        # autostart programs
        "exec-once" = [
          "uwsm app -- waybar"
          "uwsm app -- hyprpaper"
          "uwsm app -- steam -silent"
          "uwsm app -- hyprdim"
        ];

        "$terminal" = "kitty";
        "$fileManager" = "nemo";
        "$menu" = "rofi";
        "$browser" = "zen";

        "input" = {
          "kb_layout" = "us, ca, it";
          "kb_variant" = ", multix, us";
          "kb_options" = "grp:win_space_toggle";

          "touchpad" = {
            "natural_scroll" = true;
            "clickfinger_behavior" = 1;
          };

          # disable mouse acceleration
          "accel_profile" = "flat";
          "sensitivity" = -0.25;
        };

        "general" = {
          "gaps_in" = 3;
          "gaps_out" = 5;
          "border_size" = 3;
          "col.active_border" = "rgba($greenAlphaee)";
          "col.inactive_border" = "rgba($surface0Alphacc)";

          "layout" = "dwindle";
        };

        "decoration" = {
          "rounding" = 5;
          "inactive_opacity" = 0.5;

          "blur" = {
            "enabled" = true;
            "size" = 12;
            "passes" = 3;
            "vibrancy" = 0.36;
          };

          "blurls" = [
            "waybar"
            "zen"
          ];
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

        # windowrules
        "windowrule" = [
          "float, title:^(Picture-in-Picture)$"
          "size 800 450, title:(Picture-in-Picture)"
          "pin, title:^(Picture-in-Picture)"
          "float, title:^(Firefox)$"
          "size 800 450, title:(Firefox)"
          "pin, title:^(Firefox)$"
          "opacity 1 override 1 override,title:^(Picture-in-Picture)$"

          # chromium pip
          "float, title:^(Picture in picture)$"
          "pin, title:^(Picture in picture)$"
          "size 800 450, title:(Picture in picture)"
          "opacity 1 override 1 override,title:^(Picture in picture)$"
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

          # playback
          ", XF86AudioPlay, exec, uwsm app -- playerctl play-pause"
          ", XF86AudioNext, exec, uwsm app -- playerctl next"
          ", XF86AudioPrev, exec, uwsm app -- playerctl previous"

          # mute with swayosd
          ", XF86AudioMute, exec, uwsm app -- swayosd-client --max-volume 100 --output-volume mute-toggle"
        ];

        "binde" = [
          # volume control with swayosd
          ", XF86AudioRaiseVolume, exec, uwsm app -- swayosd-client --max-volume 100 --output-volume raise"
          ", XF86AudioLowerVolume, exec, uwsm app -- swayosd-client --max-volume 100 --output-volume lower"
          # screen brightness
          ", XF86MonBrightnessUp, exec, uwsm app -- swayosd-client --brightness raise"
          ", XF86MonBrightnessDown, exec, uwsm app -- swayosd-client --brightness lower"
        ];

        "bindl" = [
          # copy and pastes to the clipboard
          "$mainMod, A, exec, uwsm app -- grim -g \"$(slurp -d)\" - | swappy -f -"
          "$mainMod SHIFT, A, exec, uwsm app -- grim - | swappy -f -"
        ];

        "bindm" = [
          # drag to resize with mouse
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resize_window"
        ];
      };
    };
  };
}
