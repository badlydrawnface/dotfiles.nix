{ config, lib, pkgs, inputs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  boot.plymouth.enable = true;

  boot = {
    loader.systemd-boot.enable = lib.mkForce false;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.polkit.enable = true;

  virtualisation = {
    podman.enable = true;
    docker.enable = true;
  };

  time.timeZone = "America/New_York";
  
  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  programs.fish.enable = true;

  hardware.graphics.enable32Bit = true;
  services.pulseaudio.support32Bit = true;

  users.users.bdface = {
    isNormalUser = true;
    description = "badlydrawnface";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      "bdface".imports = [
        ./home.nix
	      inputs.catppuccin.homeManagerModules.catppuccin
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-cosmic
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  _1password.enable = true;

  #flatpak
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  system.stateVersion = "25.05";
}
