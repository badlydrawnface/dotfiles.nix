{ config, pkgs, inputs, ... }: {
  environment.systemPath = [ "/opt/homebrew/bin" ];

  # enable nix daemon
  services.nix-daemon.enable = true;

  nixpkgs.hostPlatform = "aarch64-darwin";
  
  users.users.bdface.home = "/Users/bdface";
  
  system.stateVersion = 5;
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {};
    casks = [
      "firefox@developer-edition"
      "librewolf"
      "utm"
      ];
  };

  environment.systemPackages = with pkgs; [
    coreutils
    tmux
    fastfetch
  ];

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