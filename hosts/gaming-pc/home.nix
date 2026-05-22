{
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home
  ];

  catppuccin = {
    enable = true;
    gtk.icon.enable = true;
    flavor = "mocha";
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
    source = ../../wallpapers/albany_mocha.jpg;
  };

  # profile picture
  home.file.".face" = {
    source = .../../../../config/face.png;
  };

  # host-specific monitor configuration
  wayland.windowManager.hyprland = {
    extraConfig = ''
      hl.monitor({ output = "DP-1", mode = "1920x1080@144", position = "auto" })
    '';
  };

  programs.vicinae.enable = true;

  services.tailscale-systray.enable = true;

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
    lutris
    prismlauncher
    mcpelauncher-ui-qt
    taisei
    srb2
    srb2kart
    ryubing
    audacity
    cemu
    cider-2
    heroic
    gimp
    inkscape
    pwvucontrol
    signal-desktop
    calibre
    gearlever
    via
    solaar
    qbittorrent-enhanced
    wf-recorder
    android-tools
    btop
    gnome-calculator
    jetbrains.rust-rover
    jetbrains.rider
    rtorrent
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
