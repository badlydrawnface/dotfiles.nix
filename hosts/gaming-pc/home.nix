{
  pkgs,
  inputs,
  ...
}:

{
  #TODO finish modularizing the flake
  imports = [
    ../../modules/home
    inputs.zen-browser.homeModules.twilight
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "sapphire";
    gtk.icon.enable = true;
  };

  gtkColoring.enable = true;

  # modularized configs
  browsers.brave.enable = true;
  fish.enable = true;
  git.enable = true;
  hyprland.enable = true;
  myGtk.enable = true;
  myQt.enable = true;
  myXdg.enable = true;
  nvim.enable = true;
  term.alacritty.enable = true;
  term.kitty.enable = true;
  wmCommon.enable = true;
  vscode.enable = true;
  zed.enable = true;

  home.file.".local/share/wallpapers/wallhaven-yxdrex.png" = {
    source = ../../wallpapers/wallhaven-yxdrex.png;
  };

  # profile picture
  home.file.".face" = {
    source = .../../../../config/face.png;
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

  home.stateVersion = "24.05"; # no need to change this.

  home.packages = with pkgs; [
    libreoffice
    fastfetch
    wormhole-rs
    mpv
    discord
    discover-overlay
    lutris
    prismlauncher
    mcpelauncher-ui-qt
    taisei
    srb2
    srb2kart
    ryubing
    audacity
    cemu
    youtube-music
    cider-2
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
    signal-desktop
    qbittorrent-enhanced
    grayjay
    freetube
    android-tools
    scrcpy
    btop
    opentrack
    jetbrains.rust-rover
    jetbrains.rider
    jetbrains.pycharm-professional
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
