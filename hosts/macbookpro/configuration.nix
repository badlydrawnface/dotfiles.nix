{ config, pkgs, inputs, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  # enable nix daemon
  services.nix-daemon.enable = true;

  nixpkgs.hostPlatform = "aarch64-darwin";
  
  users.users.bdface = {
    home = "/Users/bdface";
    shell = pkgs.fish;
  };
  
  system.stateVersion = 5;
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {
      SRTool = 1564122316;
      Amphetamine = 937984704;
    };
    casks = [
      # maybe not since there might not be a way to configure ff profiles on darwin
      "firefox@developer-edition"
      "librewolf"
      "utm"
      "vmware-fusion"
      "discord"
      "spotify"
      "zed"
      "obsidian"
      "zed"
      ];
  };

  environment.systemPackages = with pkgs; [
    coreutils
    tmux
    fastfetch
    neovim
    ghs
  ];

  # install ONLY the iosevka nerd font out of the nerd-fonts package
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];

  # macos tiling
  services.yabai = {
    enable = true;
  };

  # replacement status bar for macos
  services.sketchybar = {
    enable = true;
  };

  home-manager = {
    # avoid home-manager failure due to existing files
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    useUserPackages = true;
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users.bdface.imports = [
      ./home.nix
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}