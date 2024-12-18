# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos
    ];

  systemd-boot.enable = true;

  # enable ly
  ly.enable = true;
  
  # enable plymouth
  boot.plymouth.enable = true;

  ## Secure boot
  #boot.lanzaboote = {
  #  enable = true;
  #  pkiBundle = "/etc/secureboot";
  #};

  ## systemd-boot needs to be forcibly disabled with lanzaboote enabled otherwise the config will think two different bootloaders are being used
  #boot.loader.systemd-boot.enable = lib.mkForce false;

  #FIXME this doesn't work
  # external hard drive
  fileSystems."/mnt/HDD" = {
    device = "/dev/disk/by-label/HDD";
    fsType = "btrfs";
    options = [ "defaults" "user" "exec" "nofail" "x-gvfs-show"];
  };

  networking.hostName = "gaming-pc"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # enable gnome keyring for chromium secrets
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  security.polkit.enable = true;

  # enable docker and podman
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # mount usb drives and other removable media
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # enable cups
  services.printing.enable = true;

  # enable hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # enable audio
  services.pipewire = {
    enable = true;
    pulse = {
      enable = true;
    };
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/alsa.conf" ''
        monitor.alsa.rules = [
          {
            matches = [
              {
                device.name = "~alsa_card.*"
              }
            ]
            actions = {
              update-props = {
                # Device settings
                api.alsa.use-acp = true
              }
            }
          }
          {
            matches = [
              {
                node.name = "~alsa_input.pci.*"
              }
              {
                node.name = "~alsa_output.pci.*"
              }
            ]
            actions = {
            # Node settings
              update-props = {
                session.suspend-timeout-seconds = 0
              }
            }
          }
        ]
      '')
    ];
  };

  # enable fish
  programs.fish.enable = true;

  # needed for steam
  hardware.graphics.enable32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # enable dynamically-linked executables
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    nodejs_22
    python312Packages.python-lsp-server
  ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bdface = {
    isNormalUser = true;
    description = "badlydrawnface";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  home-manager = {
    # avoid home-manager failure due to existing files
    backupFileExtension = "backup";
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    users = {
      "bdface" = {
        imports = [
          ./home.nix
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable flakes and nix command, use cachix to not have to build hyprland each time
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    yt-dlp
    open-vm-tools 
    tree
    tmux
    fastfetch
    hyprcursor
    flatpak-builder
    direnv
    p7zip
    unrar
    unzip
    usbutils
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    webp-pixbuf-loader
    libwebp
    polkit-kde-agent
    distrobox
    flutter
    sbctl
    file-roller
    
    # cinnamon apps (xapps) for consistant, desktop-agnostic theming (tbd)
    nemo
    xreader
    xviewer
    xed
  ];

  # install ONLY the iosevka nerd font out of the nerd-fonts package
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    inter
  ];

  services.udev.extraRules = ''
    # Nintendo SDK debugger, which nxdumptool presents itself as
    SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", TAG+="uaccess"

    # rcm perms
    SUBSYSTEM=="usb", ATTR{idVendor}=="0955", MODE="0664", GROUP="plugdev"
  '';

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # flatpak config
  services.flatpak.enable = true;

  # add flathub
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  system.stateVersion = "24.05";
}
