{ config, lib, pkgs, inputs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  boot.secBoot.enable = true;
  boot.plymouth.enable = true;

  # 6.12 is too old (i think its lts) ryzen ai 300 needs latest kernel to avoid gpu hangs
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # firmware updates
  services.fwupd.enable = true;

  xdgPortals.enable = true;
  
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  fingerprint.enable = true;

  virtualisation = {
    podman.enable = true;
    docker.enable = true;
    waydroid.enable = true;
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

  # necessary for steam
  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };

  hardware.graphics.enable32Bit = true;
  services.pulseaudio.support32Bit = true;

  users.users.bdface = {
    isNormalUser = true;
    description = "badlydrawnface";
    extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "uucp" ];
    shell = pkgs.fish;
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      "bdface".imports = [
        ./home.nix
	inputs.catppuccin.homeModules.catppuccin
      ];
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    plover.dev
    
    #gui apps
    # kdePackages.dolphin
    #kdePackages.gwenview
    #kdePackages.ark
    #kdePackages.okular
    # kdePackages.kate
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    fira
  ];

  _1password.enable = true;

  # enable flatpak and add flathub repo
  flathub.enable = true;

  # make ozones (vscode, et al) use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "25.05";
}
