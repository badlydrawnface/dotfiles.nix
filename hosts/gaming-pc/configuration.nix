# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # this must be mkForce disabled or else nix will think two bootloaders are enabled at once
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;

  # Secure boot
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  #FIXME this doesn't work
  # external hard drive
  fileSystems."/media/hdd" = 
  { device = "/dev/disk/by-uuid/0b67b245-ccc3-4560-b544-70c93f0a4499";
    fsType = "btrfs";
    options = [ "defaults" "user" "exec" "nofail" "noatime" ];
  };

  networking.hostName = "gaming-pc"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # enable gnome keyring for chromium secrets
  services.gnome.gnome-keyring.enable = true;

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
  programs.hyprlock.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bdface = {
    isNormalUser = true;
    description = "badlydrawnface";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  home-manager = {
    # avoid home-manager failure due to existing files
    backupFileExtension = "bak";
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "bdface" = {
        imports = [
          ./home.nix
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };

  # # overlay file-roller to compile the non-libadwaita version from mint
  # nixpkgs.overlays = [
  #   (import ../../overlays/file-roller.nix)
  # ];

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
    qt5ct
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
