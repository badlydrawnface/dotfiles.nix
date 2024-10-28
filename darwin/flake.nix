  
{
  # just to see if firefox is workable, might reinstall macos
  description = "MacOS Nix set up with Firefox and Firefox Extensions";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    darwinConfigurations. =
      inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
        modules = [
          ({ pkgs, ... }: {
            # here go the darwin preferences and config items
            environment.systemPackages = [ pkgs.coreutils ];
            environment.systemPath = [ "/opt/homebrew/bin" ];
            nix.extraOptions = ''
              experimental-features = nix-command flakes
             '';
             system.keyboard.enableKeyMapping = true;
             system.keyboard.remapCapsLockToEscape = true;
             services.nix-daemon.enable = true;
             users.users..home = "/Users/";
             system.defaults.dock.autohide = true;
             # backwards compatability; don't change
             system.stateVersion = 4;
             homebrew = {
              enable = true;
              caskArgs.no_quarantine = true;
              global.brewfile = true;
              masApps = {};
              casks = [ "firefox" ];
             };
           })
           inputs.home-manager.darwinModules.home-manager
           {
             home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users..imports = [
                ({ pkgs, ... }: {
                  home.stateVersion = "22.11";
                  # Specify some home-manager configs
                  home.packages = [ pkgs.ripgrep ];
                  home.sessionVariables = {
                    EDITOR = "vim";
                  };
                  programs.git = { 
                    enable = true;
                   };
                  programs.firefox = {
                    enable = true;
                    # the command below was the critical addition
                    package = null;
                    profiles. = {
                      isDefault = true;
                      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
                        ublock-origin
                        bitwarden
                        vimium
                      ];
                    };
                  };
                })
              ];
            };
          }
        ];
      };
  };
}