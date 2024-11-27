{ config, pkgs, inputs, outputs, ... }:

# define hyprland flake packages
let
  hyprlandPkgs = inputs.hyprland.packages.${pkgs.system};
  hyprsunsetPkgs = inputs.hyprsunset.packages.${pkgs.system};
in

{
  # # TODO finish modularizing the flake
  imports = [
    ../../modules/home
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "sapphire";
  };


  # modularized configs

  alacritty.enable = true;
  fish.enable = true;
  gh.enable = true;
  git.enable = true;
  myGtk.enable = true;
  hyprland.enable = true;
  nextcloud.enable = true;
  #TODO nnn config
  nvim.enable = true;
  vscode.enable = true;
  myXdg.enable = true;

  home.file.".local/share/wallpapers/wallhaven-yxdrex.png" = {
    source = ../../wallpapers/wallhaven-yxdrex.png;
  };

  services.swayosd = {
    enable = true;
  };

  services.playerctld = {
    enable = true;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # TODO move this to theming modules
  # set prefer-dark for gtk4 and others
  dconf.settings = {
    "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
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
    litemdview
    brave
    vivaldi
    vivaldi-ffmpeg-codecs
    discord
    zed-editor
    gradience
    fastfetch
    wl-clipboard
    wormhole-rs
    steam
    mpv
    discord
    discover-overlay
    lutris
    prismlauncher
    dolphin-emu
    ryujinx
    audacity
    cemu
    spotify
    heroic
    gimp
    inkscape
    kdenlive
    catppuccin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    wlsunset
    pavucontrol
    grimblast
    android-studio
    calibre
  ];

  home.sessionVariables = {
    GRIMBLAST_EDITOR = "xviewer";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
