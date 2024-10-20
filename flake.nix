{
  description = "bdface's nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # more up to date version of hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # new hypr tools not in nixpkgs yet
    hyprsunset = {
      url = "github:hyprwm/hyprsunset";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprsysteminfo = {
      url = "github:hyprwm/hyprsysteminfo";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    
  };

  outputs = { self, nixpkgs, hyprland, hyprsunset, ... }@inputs: {
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
          inputs.home-manager.nixosModules.default

        ];
      };
    };
  };
}
