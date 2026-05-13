{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../../modules/home
  ];

  catppuccin = {
    enable = true;
    gtk.icon.enable = true;
    flavor = "latte";
    accent = "yellow";
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
  term.kitty.enable = true;
  wmCommon.enable = true;
  vscode.enable = true;
  zed.enable = true;

  home.file.".local/share/wallpapers/current" = {
    source = ../../wallpapers/albany_latte.jpg;
  };

  # profile picture
  home.file.".face" = {
    source = .../../../../config/face.png;
  };

  # host-specific monitor configuration
  wayland.windowManager.hyprland = {
    settings = {
      "monitor" = [
        "eDP-1,preferred,auto,1.566667"
      ];
    };
  };

  home.username = "bdface";
  home.homeDirectory = "/home/bdface";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    libreoffice
    fastfetch
    wormhole-rs
    mpv
    (discord.override {
      withVencord = true;
    })
    discover-overlay
    prismlauncher
    mcpelauncher-ui-qt
    taisei
    srb2
    #srb2kart
    dolphin-emu
    ryubing
    audacity
    cemu
    cider-2
    gimp
    inkscape
    pwvucontrol
    signal-desktop
    #grayjay
    calibre
    gearlever
    openai-whisper
    qbittorrent-enhanced
    wf-recorder
    freetube
    android-tools
    scrcpy
    btop
    jetbrains.rust-rover
    jetbrains.rider
    #jetbrains.pycharm-professional
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
