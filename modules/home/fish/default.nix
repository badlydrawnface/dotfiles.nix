{ pkgs, lib, config, ... }: {

  options = {
    fish.enable = lib.mkEnableOption "Enable fish shell, configure starship";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        starship init fish | source
      '';
    };

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        aws = {
          disabled = true;
        };
      };
    };
  };
}