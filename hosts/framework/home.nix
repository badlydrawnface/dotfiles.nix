{ config, pkgs, inputs, outputs, ... }:

# define hyprland flake packages
let
  hyprlandPkgs = inputs.hyprland.packages.${pkgs.system};
in

{
  # # TODO finish modularizing the flake
  imports = [
    ../../modules/home
    inputs.zen-browser.homeModules.beta
  ];

  catppuccin = {
    enable = true;
    gtk.enable = true;
    flavor = "latte";
    accent = "sapphire";
  };

  # modularized configs
  alacritty.enable = true;
  fish.enable = true;
  gh.enable = true;
  git.enable = true;
  hyprland.enable = true;
  myGtk.enable = true;
  nvim.enable = true;
  vscode.enable = true;
  myXdg.enable = true;

  home.file.".local/share/wallpapers/wallhaven-yxdrex.png" = {
    source = ../../wallpapers/wallhaven-yxdrex.png;
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
  wayland.windowManager.hyprland = {
    settings = {
      "monitor" = "eDP-1,preferred,auto,1.566667";
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
    steamguard-cli
    openai-whisper
  ];

  home.sessionVariables = {
    GRIMBLAST_EDITOR = "xviewer";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
