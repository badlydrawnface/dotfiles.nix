{
  description = "bdface's nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";

    catppuccin = {
      url = "github:catppuccin/nix";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" ];       
      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
    in {
      # custom packages
      packages = forEachPkgs (pkgs: import ./pkgs { inherit pkgs; });

      nixosConfigurations = {
        vm-test = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/vm-test/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

        gaming-pc = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/gaming-pc/configuration.nix
	    inputs.catppuccin.nixosModules.catppuccin
            inputs.lanzaboote.nixosModules.lanzaboote
            inputs.home-manager.nixosModules.default
          ];
        };

        framework = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
	    modules = [
	      ./hosts/framework/configuration.nix		   
	      inputs.catppuccin.nixosModules.catppuccin
              inputs.lanzaboote.nixosModules.lanzaboote
              inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
  }
