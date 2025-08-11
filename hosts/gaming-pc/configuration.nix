{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  boot.secBoot.enable = true;

  # enable plymouth
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

  networking.hostName = "gaming-pc"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # enable gnome keyring for secrets
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  security.polkit.enable = true;

  # enable docker and podman
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
    waydroid.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

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

  # mount usb drives and other removable media
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # enable cups
  services.printing.enable = true;

  desktops.hyprland.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  pipewire.enable = true;
  # disable hdmi audio suspend
  services.pipewire = {
    wireplumber.configPackages = [
      #FIXME this doesn't work
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

  # brave
  browserPolicies.enable = true;

  # needed for steam
  hardware.graphics.enable32Bit = true;
  services.pulseaudio.support32Bit = true;
  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bdface = {
    isNormalUser = true;
    description = "badlydrawnface";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
    shell = pkgs.fish;
  };

  home-manager = {
    # avoid home-manager failure due to existing files
    backupFileExtension = "backup";
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      "bdface" = {
        imports = [
          ./home.nix
          inputs.catppuccin.homeModules.catppuccin
        ];
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    yt-dlp
    open-vm-tools
    tree
    tmux
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
    ns-usbloader
    gpu-screen-recorder
    gpu-screen-recorder-gtk

    # GUI apps
    nemo
    file-roller
    evince
  ];

  services.udev.packages = [ pkgs.dolphin-emu ];

  programs.gpu-screen-recorder = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    # install iosevka nerd font
    nerd-fonts.iosevka
    fira
  ];

  services.udev.extraRules = ''
    # Nintendo SDK debugger, which nxdumptool presents itself as
    SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", TAG+="uaccess"

    # rcm perms
    SUBSYSTEM=="usb", ATTR{idVendor}=="0955", MODE="0664", GROUP="plugdev"
  '';

  flathub.enable = true;

  system.stateVersion = "24.05";
}
