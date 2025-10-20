{
  config, 
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  boot.secBoot.enable = true;
  boot.plymouth.enable = true;

  # external hard drive
  fileSystems."/mnt/HDD" = {
    device = "/dev/disk/by-label/HDD";
    fsType = "btrfs";
    options = [
      "defaults"
      "user"
      "exec"
      "nofail"
      "x-gvfs-show"
    ];
  };

  # latest mainline kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.extraModulePackages = [
    config.boot.kernelPackages.gcadapter-oc-kmod
  ];

  # to autoload at boot:
  boot.kernelModules = [
    "gcadapter_oc"
  ];

  services.power-profiles-daemon.enable = true;


  networking.hostName = "gaming-pc";
  networking.networkmanager.enable = true;

  desktops.hyprland.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  virtualisation = {
    docker.enable = true;
    podman.enable = true;
    waydroid.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

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
      pkgs.hplipWithPlugin
      pkgs.sane-airscan
    ];
    disabledDefaultBackends = [ "escl" ];
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
      "https://cosmic.cachix.org/"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
      "https://cosmic.cachix.org/"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
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
    gpu-screen-recorder-gtk
    freetype
    glib

    # GUI apps
    evince
    loupe
  ];

  fonts.packages = with pkgs; [
    # install iosevka nerd font
    adwaita-fonts
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  programs.localsend.enable = true;

  services.udev.packages = [ pkgs.dolphin-emu ];

  programs.gpu-screen-recorder = {
    enable = true;
  };

  services.udev.extraRules = ''
    # Nintendo SDK debugger, which nxdumptool presents itself as
    SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", TAG+="uaccess"

    # rcm perms
    SUBSYSTEM=="usb", ATTR{idVendor}=="0955", MODE="0664", GROUP="plugdev"
  '';

  # enable flatpak and add flathub repo
  flathub.enable = true;

  system.stateVersion = "25.05";
}
