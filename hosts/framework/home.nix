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
    flavor = "macchiato";
    accent = "sapphire";
  };

  # modularized configs
  alacritty.enable = true;
  fish.enable = true;
  gh.enable = true;
  git.enable = true;
  myGtk.enable = true;
  nvim.enable = true;
  vscode.enable = true;
  myXdg.enable = true;

  home.file.".local/share/wallpapers/wallhaven-yxdrex.png" = {
    source = ../../wallpapers/wallhaven-yxdrex.png;
  };

  services.playerctld = {
    enable = true;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # host-specific monitor configuration
  wayland.windowManager.hyprland = {
    settings = {
      "monitor" = "eDP-1,preferred,auto,1";
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
    zed-editor
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
    kdePackages.kdenlive
    pavucontrol
    calibre
  ];

  home.sessionVariables = {
    GRIMBLAST_EDITOR = "xviewer";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
