{ config, lib, pkgs, inputs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  boot.secBoot.enable = true;
  # sddm is crashing on login, so disable it for now
  # sddm.enable = true;

  # this must be above a desktop declaration in order for the caching to work
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://hyprland.cachix.org/"
      "https://cosmic.cachix.org/"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  #TODO modularize this as 'config.hyprland.enable'
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  
  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  fingerprint.enable = true;

  virtualisation = {
    podman.enable = true;
    docker.enable = true;
  };

  # mount usb drives and other removable media
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;


  time.timeZone = "America/New_York";
  
  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;

  # this is necessary to set the default shell
  programs.fish.enable = true;

  hardware.graphics.enable32Bit = true;
  services.pulseaudio.support32Bit = true;

  users.users.bdface = {
    isNormalUser = true;
    description = "badlydrawnface";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    yt-dlp
    tree
    tmux
    fastfetch
    flatpak-builder
    direnv
    p7zip
    unrar
    unzip
    usbutils
    webp-pixbuf-loader
    libwebp
    distrobox
    wl-clipboard
    adw-gtk3
    
    # gui apps
    kdePackages.dolphin
    kdePackages.gwenview
    kdePackages.ark
    kdePackages.okular
    kdePackages.kate
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    fira
  ];

  _1password.enable = true;

  # make ozones (vscode, et al) use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "25.05";
}
