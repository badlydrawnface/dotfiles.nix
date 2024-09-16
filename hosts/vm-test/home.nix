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
    #TODO
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
        font = "Iosevka Nerd Font:size=11";
      };
    };
  };

  programs.kitty = {
    enable = true;
    extraConfig = 
    ''
    background-opacity 0.7
    '';
  };

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
    settings = [{
      "modules-left" = [
        "custom-launcher"
	"hyprland/workspaces"
	"custom/media"
      ];
      "modules-center" = [
      	 "hyprland/window"
      ];
      "modules-right" = [
         "tray"
	 "hyprland/language"
	 "backlight"
	 "network"
	 "battery"
	 "wireplumber"
	 "clock"
      ];
    }];
    style =
    ''
    @import "colors.css";

    * {
      font-family: Iosevka;
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
    #wireplumber {
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
    '';
  };

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
    prismlauncher
    dolphin-emu
    gradience
    pywal16
    pywalfox-native
    imagemagick
    swaybg

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
