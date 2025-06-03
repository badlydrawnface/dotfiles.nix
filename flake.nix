{
  description = "bdface's nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    
  };

  outputs = { self, nixpkgs, lanzaboote, ... }@inputs: {
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
          lanzaboote.nixosModules.lanzaboote
          inputs.home-manager.nixosModules.default
        ];
      };

      framework = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
	      modules = [
          ./hosts/framework/configuration.nix
          inputs.catppuccin.nixosModules.catppuccin
          lanzaboote.nixosModules.lanzaboote
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
