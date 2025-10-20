{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../../modules/home
    inputs.zen-browser.homeModules.twilight
    inputs.eden.homeModules.default
  ];

  catppuccin = {
    enable = true;
    gtk.icon.enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  gtkColoring.enable = true;

  # modularized configs
  browsers.brave.enable = true;
  programs.zen-browser.enable = true;
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

  programs.eden.enable = true;

  home.file.".local/share/wallpapers/G2l_3J6WsAA06aR.jpeg" = {
    source = ../../wallpapers/G2l_3J6WsAA06aR.jpeg;
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

  home.username = "bdface";
  home.homeDirectory = "/home/bdface";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    libreoffice
    fastfetch
    wormhole-rs
    mpv
    (discord.override {
      withVencord = true;
    })
    discover-overlay
    lutris
    prismlauncher
    mcpelauncher-ui-qt
    taisei
    srb2
    #srb2kart
    ryubing
    audacity
    cemu
    cider-2
    heroic
    gimp
    inkscape
    pavucontrol
    signal-desktop
    grayjay
    calibre
    gearlever
    via
    solaar
    openai-whisper
    qbittorrent-enhanced
    wf-recorder
    freetube
    android-tools
    scrcpy
    btop
    jetbrains.rust-rover
    jetbrains.rider
    jetbrains.pycharm-professional
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
