{ config, pkgs, inputs, outputs, ... }:

{
  #TODO finish modularizing the flake
  imports = [
    ../../modules/home
    inputs.zen-browser.homeModules.beta
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "green";
    gtk = {
      enable = true;
      icon.enable = true;
    };
  };

  # modularized configs
  fish.enable = true;
  gh.enable = true;
  git.enable = true;
  hyprland.enable = true;
  myGtk.enable = true;
  # myQt.enable = true;
  myXdg.enable = true;
  nvim.enable = true;
  term.alacritty.enable = true;
  wmCommon.enable = true;
  vscode.enable = true;
  yazi.enable = true;
  zed.enable = true;

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };

  home.file.".local/share/wallpapers/wallhaven-5g22q5.png" = {
    source = ../../wallpapers/wallhaven-5g22q5.png;
  };

  # host-specific monitor configuration
  wayland.windowManager.hyprland = {
    settings = {
      "monitor" = "DP-1,1920x1080@144,auto,1";
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
    brave
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
