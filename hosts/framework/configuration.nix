{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  boot.loader.systemd-boot.enable = true;

  # latest mainline kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # firmware updates
  services.fwupd.enable = true;

  services.power-profiles-daemon.enable = true;

  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  fingerprint.enable = true;

  desktops.hyprland.enable = true;

  sddm.enable = true;

  virtualisation = {
    docker.enable = true;
    podman.enable = true;
    waydroid.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  # tailscale
  services.tailscale.enable = true;

  programs.virt-manager.enable = true;

  # mount usb drives and other removable media
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "all" ];

  services.printing.enable = true;
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.sane-airscan
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  # this is necessary in order to set the default shell
  programs.fish.enable = true;

  # enable flakes and nix command, use cachix to not have to build hyprland each time
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  pipewire.enable = true;

  # necessary for steam
  hardware.graphics.enable32Bit = true;
  services.pulseaudio.support32Bit = true;
  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };

  programs.gamescope.enable = true;

  # appimage support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # brave policies
  browserPolicies.enable = true;

  users.users.bdface = {
    isNormalUser = true;
    description = "badlydrawnface";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirt"
      "scanner"
      "lp"
    ];
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

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    yt-dlp
    tree
    fastfetch
    flatpak-builder
    direnv
    dolphin-emu
    p7zip
    unrar
    unzip
    usbutils
    webp-pixbuf-loader
    libwebp
    distrobox
    wl-clipboard
    #gscan2pdf
    freetype
    glib

    # GUI apps
    evince
    loupe
    nautilus
  ];

  fonts.packages = with pkgs; [
    # install iosevka nerd font
    nerd-fonts.fantasque-sans-mono
    adwaita-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  programs.localsend.enable = true;

  services.udev.packages = [ pkgs.dolphin-emu ];

  # enable flatpak and add flathub repo
  flathub.enable = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
  };

  # bluetooth
  hardware.bluetooth.enable = true;

  # make ozones (vscode et al.) use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "25.05";
}
