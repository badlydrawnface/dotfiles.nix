{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}:
{
  # # TODO finish modularizing the flake
  imports = [
    ../../modules/home
    inputs.zen-browser.homeModules.beta
  ];

  catppuccin = {
    enable = true;
    gtk = {
      enable = true;
      icon.enable = true;
    };
    flavor = "macchiato";
    accent = "green";
  };

  # necessary since catppuccin's flake doesn't change the icon theme
  programs.vscode.profiles.default.userSettings."workbench.iconTheme" =
    lib.mkForce "catppuccin-macchiato";

  # modularized configs
  fish.enable = true;
  gh.enable = true;
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
  yazi.enable = true;
  zed.enable = true;

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
    adw-gtk3
    fastfetch
    wormhole-rs
    steam
    mpv
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
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
    gimp
    inkscape
    signal-desktop
    grayjay
    pavucontrol
    calibre
    steamguard-cli
    openai-whisper
    flameshot
    wf-recorder
    grayjay
    freetube
    android-tools
    scrcpy
    btop
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
