{ pkgs, lib, config, ... }: {

  options = {
    fish.enable = lib.mkEnableOption "Enable fish shell, configure starship";
  };

  config = lib.mkIf config.nextcloud.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        starship init fish | source
      '';
    };

    programs.starship = {
      enable = true;
      settings = {
        aws = {
          disabled = true;
        };
      };
    };
  };
}