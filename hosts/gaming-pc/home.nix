{ config, pkgs, inputs, outputs, ... }:

# define hyprland flake packages
let
  hyprlandPkgs = inputs.hyprland.packages.${pkgs.system};
  hyprsunsetPkgs = inputs.hyprsunset.packages.${pkgs.system};
in

{
  #TODO finish modularizing the flake
  imports = [
    ../../modules/home
    inputs.zen-browser.homeModules.beta
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "sapphire";
    gtk = {
      enable = true;
      icon.enable = true;
    };
  };

  # modularized configs
  alacritty.enable = true;
  fish.enable = true;
  gh.enable = true;
  git.enable = true;
  hyprland.enable = true;
  myGtk.enable = true;
  myQt.enable = true;
  nvim.enable = true;
  vscode.enable = true;
  myXdg.enable = true;

  # TODO desktop module rewrite
  programs.swaylock.enable = true;

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };

  home.file.".local/share/wallpapers/wallhaven-o5k7kl.jpg" = {
    source = ../../wallpapers/wallhaven-o5k7kl.jpg;
  };

  # niri config (not declarable yet)
  home.file.".config/niri/config.kdl" = {
    source = ../../config/niri.kdl;
  };

  # host-specific monitor configuration
  wayland.windowManager.hyprland = {
    settings = {
      "monitor" = "DP-1,1920x1080@144,auto,1";
    };
  };

  # TODO move this to theming modules...  
  # FIXME eventually
  # set prefer-dark for gtk4 and others
  dconf.settings = {
    "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
  };

  # get the python script for the media player
  home.file.".config/waybar/mediaplayer.py" = {
    source = ../../config/waybar/mediaplayer.py;
  };

  home.username = "bdface";
  home.homeDirectory = "/home/bdface";


  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    libreoffice
    zed-editor
    fastfetch
    wormhole-rs
    steam
    mpv
    discord
    discover-overlay
    lutris
    prismlauncher
    mcpelauncher-ui-qt
    taisei
    srb2
    srb2kart
    dolphin-emu
    ryujinx
    audacity
    cemu
    spotify
    heroic
    gimp
    inkscape
    kdePackages.kdenlive
    pavucontrol
    calibre
    gearlever
    via
    solaar
    openai-whisper
    steamguard-cli
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
