{ pkgs, lib, config, ... }: {
  options = {
    yazi.enable = lib.mkEnableOption {
      default = false;
      description = "Enable and configure yazi";
    };
  };

  config = lib.mkIf config.yazi.enable { 
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
