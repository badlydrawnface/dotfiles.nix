{ config, pkgs, inputs, outputs, ... }:

{
  # # TODO finish modularizing the flake
  imports = [
    ../../modules/home
    inputs.zen-browser.homeModules.beta
  ];

  #catppuccin = {
    #enable = true;
    #gtk.enable = true;
    #flavor = "macchiato";
    #accent = "green";
  #};

  # modularized configs
  alacritty.enable = true;
  fish.enable = true;
  gh.enable = true;
  git.enable = true;
  #hyprland.enable = true;
  #myGtk.enable = true;
  #myQt.enable = true;
  plasma.enable = true;
  nvim.enable = true;
  vscode.enable = true;
  myXdg.enable = true;

  home.file.".local/share/wallpapers/wallhaven-5g22q5.png" = {
    source = ../../wallpapers/wallhaven-5g22q5.png;
  };

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };

  # host-specific monitor configuration
  #wayland.windowManager.hyprland = {
    #settings = {
      #"monitor" = "eDP-1,preferred,auto,1.566667";

      # save on battery life
      #"decoration:blur:enabled" = false;
      #"decoration:shadow:enabled" = false;
      #"misc:vfr" = true;
    #};
  #};

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
    srb2kart
    dolphin-emu
    ryujinx
    audacity
    cemu
    spotify
    heroic
    gimp
    inkscape
    signal-desktop
    grayjay
    kdePackages.kdenlive
    pavucontrol
    calibre
    steamguard-cli
    openai-whisper
    grimblast
    wf-recorder
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
